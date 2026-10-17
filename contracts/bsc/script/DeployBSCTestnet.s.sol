// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {WrappedBLUEX} from "../src/WrappedBLUEX.sol";

/// @notice Explicitly restricted to BSC Testnet (97). Never deploys mainnet.
contract DeployBSCTestnet is Script {
    error IncorrectChain(uint256 observed);

    function run() external returns (WrappedBLUEX token) {
        if (block.chainid != 97) revert IncorrectChain(block.chainid);
        address admin = vm.envAddress("BSC_ADMIN_ADDRESS");
        require(admin != address(0), "BSC_ADMIN_ADDRESS must be nonzero");

        vm.startBroadcast();
        token = new WrappedBLUEX(admin);
        vm.stopBroadcast();

        require(token.paused(), "Unexpected unpaused token");
        require(token.totalSupply() == 0, "Unexpected premint");
    }
}
