// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {ERC20Pausable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import {AccessControlDefaultAdminRules} from "@openzeppelin/contracts/access/extensions/AccessControlDefaultAdminRules.sol";

/// @notice BSC representation of BLUEX; NOT a TON proof verifier or live bridge.
/// @dev reportedLockedBacking is an admin assertion. Only independently verified escrow
///      may justify granting a MINTER_ROLE or opening transfers in production.
contract WrappedBLUEX is ERC20, ERC20Capped, ERC20Pausable, AccessControlDefaultAdminRules {
    uint256 public constant ORIGINAL_TON_SUPPLY = 100_000_000 * 10 ** 9;
    string public constant ORIGINAL_TON_JETTON = "EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ";

    bytes32 public constant MINTER_ROLE = keccak256("BLUEX_BACKED_MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("BLUEX_EMERGENCY_PAUSER_ROLE");

    uint256 public reportedLockedBacking;
    mapping(bytes32 => bool) public usedEvidenceHashes;

    error ZeroAmount();
    error EvidenceRequired();
    error EvidenceAlreadyUsed();
    error InvalidBacking();
    error ExceedsReportedBacking(uint256 requestedSupply, uint256 backingLimit);

    event BackingLimitReported(uint256 previousLimit, uint256 newLimit, bytes32 indexed evidenceHash);

    constructor(address initialAdmin)
        ERC20("Wrapped BlueCoin", "wBLUEX")
        ERC20Capped(ORIGINAL_TON_SUPPLY)
        AccessControlDefaultAdminRules(2 days, initialAdmin)
    {
        _grantRole(PAUSER_ROLE, initialAdmin);
        _pause();
    }

    function decimals() public pure override returns (uint8) {
        return 9;
    }

    /// @notice Admin-reported TON escrow limit; NOT independent on-chain proof.
    function reportBacking(uint256 newLimit, bytes32 evidenceHash)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        if (evidenceHash == bytes32(0)) revert EvidenceRequired();
        if (usedEvidenceHashes[evidenceHash]) revert EvidenceAlreadyUsed();
        if (newLimit > ORIGINAL_TON_SUPPLY || newLimit < totalSupply()) revert InvalidBacking();

        uint256 previous = reportedLockedBacking;
        usedEvidenceHashes[evidenceHash] = true;
        reportedLockedBacking = newLimit;
        emit BackingLimitReported(previous, newLimit, evidenceHash);
    }

    /// @notice No minter exists at deployment. Unpause and grant are explicit admin acts.
    function mint(address to, uint256 amount) external onlyRole(MINTER_ROLE) whenNotPaused {
        if (amount == 0) revert ZeroAmount();
        uint256 requestedSupply = totalSupply() + amount;
        if (requestedSupply > reportedLockedBacking) {
            revert ExceedsReportedBacking(requestedSupply, reportedLockedBacking);
        }
        _mint(to, amount);
    }

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /// @notice Emergency pauser cannot unpause. Only default admin can.
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    function _update(address from, address to, uint256 value)
        internal
        override(ERC20, ERC20Capped, ERC20Pausable)
    {
        super._update(from, to, value);
    }
}
