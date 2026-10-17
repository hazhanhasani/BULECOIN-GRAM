// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {WrappedBLUEX} from "../src/WrappedBLUEX.sol";

contract WrappedBLUEXTest is Test {
    WrappedBLUEX private token;
    address private constant ADMIN = address(0xA11CE);
    address private constant MINTER = address(0xB0B);
    address private constant HOLDER = address(0xCAFE);
    address private constant UNTRUSTED = address(0xDEAD);
    uint256 private constant UNIT = 1e9;

    function setUp() public {
        token = new WrappedBLUEX(ADMIN);
    }

    function testInitialStateIsSafe() public view {
        assertEq(token.name(), "Wrapped BlueCoin");
        assertEq(token.symbol(), "wBLUEX");
        assertEq(token.decimals(), 9);
        assertEq(token.cap(), 100_000_000 * UNIT);
        assertEq(token.totalSupply(), 0);
        assertEq(token.reportedLockedBacking(), 0);
        assertEq(token.defaultAdmin(), ADMIN);
        assertTrue(token.paused());
        assertFalse(token.hasRole(token.MINTER_ROLE(), ADMIN));
        assertFalse(token.hasRole(token.MINTER_ROLE(), MINTER));
    }

    function testUnauthorizedOperationsRevert() public {
        vm.expectRevert();
        vm.prank(UNTRUSTED);
        token.reportBacking(UNIT, bytes32(uint256(1)));

        vm.expectRevert();
        vm.prank(MINTER);
        token.mint(HOLDER, UNIT);

        vm.expectRevert();
        vm.prank(UNTRUSTED);
        token.unpause();
    }

    function testBackingMustHaveUniqueEvidenceAndStayUnderCap() public {
        vm.startPrank(ADMIN);
        vm.expectRevert(WrappedBLUEX.EvidenceRequired.selector);
        token.reportBacking(UNIT, bytes32(0));

        token.reportBacking(10 * UNIT, bytes32(uint256(1)));
        assertEq(token.reportedLockedBacking(), 10 * UNIT);

        vm.expectRevert(WrappedBLUEX.EvidenceAlreadyUsed.selector);
        token.reportBacking(11 * UNIT, bytes32(uint256(1)));

        vm.expectRevert(WrappedBLUEX.InvalidBacking.selector);
        token.reportBacking(100_000_001 * UNIT, bytes32(uint256(2)));
        vm.stopPrank();
    }

    function testMintRejectedWhilePaused() public {
        vm.startPrank(ADMIN);
        token.grantRole(token.MINTER_ROLE(), MINTER);
        vm.stopPrank();

        vm.expectRevert();
        vm.prank(MINTER);
        token.mint(HOLDER, UNIT);
    }

    function testMintRequiresBackingAndRole() public {
        vm.startPrank(ADMIN);
        token.grantRole(token.MINTER_ROLE(), MINTER);
        token.unpause();
        vm.stopPrank();

        vm.expectRevert();
        vm.prank(MINTER);
        token.mint(HOLDER, UNIT);

        vm.prank(ADMIN);
        token.reportBacking(10 * UNIT, bytes32(uint256(1)));

        vm.prank(MINTER);
        token.mint(HOLDER, 10 * UNIT);
        assertEq(token.balanceOf(HOLDER), 10 * UNIT);

        vm.expectRevert();
        vm.prank(MINTER);
        token.mint(HOLDER, UNIT);
    }

    function testCannotReduceBackingBelowIssuedSupply() public {
        vm.startPrank(ADMIN);
        token.reportBacking(10 * UNIT, bytes32(uint256(1)));
        token.grantRole(token.MINTER_ROLE(), MINTER);
        token.unpause();
        vm.stopPrank();

        vm.prank(MINTER);
        token.mint(HOLDER, 5 * UNIT);

        vm.expectRevert(WrappedBLUEX.InvalidBacking.selector);
        vm.prank(ADMIN);
        token.reportBacking(4 * UNIT, bytes32(uint256(2)));
    }

    function testEmergencyPauseFreezesTransfers() public {
        vm.startPrank(ADMIN);
        token.reportBacking(UNIT, bytes32(uint256(1)));
        token.grantRole(token.MINTER_ROLE(), MINTER);
        token.unpause();
        vm.stopPrank();

        vm.prank(MINTER);
        token.mint(HOLDER, UNIT);

        vm.prank(ADMIN);
        token.pause();

        vm.expectRevert();
        vm.prank(HOLDER);
        token.transfer(UNTRUSTED, UNIT);
    }

    function testZeroMintIsNotAllowed() public {
        vm.startPrank(ADMIN);
        token.grantRole(token.MINTER_ROLE(), MINTER);
        token.unpause();
        vm.stopPrank();

        vm.expectRevert(WrappedBLUEX.ZeroAmount.selector);
        vm.prank(MINTER);
        token.mint(HOLDER, 0);
    }

    function testDefaultAdminTransferRequiresTwoDays() public {
        vm.prank(ADMIN);
        token.beginDefaultAdminTransfer(UNTRUSTED);

        vm.expectRevert();
        vm.prank(UNTRUSTED);
        token.acceptDefaultAdminTransfer();

        vm.warp(block.timestamp + 2 days + 1);
        vm.prank(UNTRUSTED);
        token.acceptDefaultAdminTransfer();
        assertEq(token.defaultAdmin(), UNTRUSTED);
    }
}
