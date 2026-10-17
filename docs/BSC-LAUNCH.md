# BLUEX on BNB Smart Chain — Testnet foundation

**STATUS: Prepared source code only. NOT deployed on BSC mainnet or testnet. NOT an operational bridge.**

The canonical BLUEX is the non-mintable TON Jetton at `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`, with a fixed 100,000,000 BLUEX supply. Deploying another independent supply would inflate circulating economic supply. This implementation is a proposed **wrapped** representation (wBLUEX), with a 9-decimal ERC-20/BEP-20 interface.

| Network | Chain ID | RPC | Explorer |
| --- | --- | --- | --- |
| BSC Testnet | 97 | https://bsc-testnet-dataseed.bnbchain.org | https://testnet.bscscan.com |
| BSC Mainnet | 56 | https://bsc-dataseed.bnbchain.org | https://bscscan.com |

[Official network configuration](https://docs.bnbchain.org/bnb-smart-chain/developers/json_rpc/json-rpc-endpoint/).

## Contract safety

- Zero supply on deployment; paused; no minter granted; zero reported backing.
- Constant cap equal to the original 100 million BLUEX, preserving 9 decimals.
- The default administrator is a provided address (use multisig governance), with a delayed two-step transfer.
- The emergency pauser can freeze activity; only the default admin can unpause.
- `reportBacking(newLimit, evidenceHash)` allows the multisig administrator to register a *claimed* amount of BLUEX locked on TON. An evidence hash cannot be reused; the limit may not exceed 100m or be less than minted supply.
- **A self-reported backing limit is NOT cryptographic proof of TON reserves.** Do not grant the minter role before genuine escrow and verification exist.
- No redemption/burn-to-unlock mechanism, TON escrow contract, relayer, TON proof verifier, replay-protected attestation or reserve oracle is implemented. **Do not accept real user deposits.**

## Development

Install [Foundry](https://getfoundry.sh/), then run at repository root:

```bash
forge install --no-git OpenZeppelin/openzeppelin-contracts@v5.4.0
forge install --no-git foundry-rs/forge-std@v1.9.7
forge build
forge test -vvv
```

Version tags are pinned; record the exact library SHAs before a production audit.

## Testnet deployment (manual, safe by default)

Use a dedicated **testnet** wallet funded only with tBNB (never reuse TON treasury keys). Set `BSC_ADMIN_ADDRESS` to your controlled testnet admin address. Sign locally with a secure Foundry keystore; **never paste keys in GitHub, frontend or chat**:

```bash
export BSC_ADMIN_ADDRESS=0xYOUR_TESTNET_ADMIN_ADDRESS
forge script contracts/bsc/script/DeployBSCTestnet.s.sol:DeployBSCTestnet \
  --rpc-url https://bsc-testnet-dataseed.bnbchain.org \
  --account my-testnet-deployer --broadcast
```

This script rejects all chain IDs other than **97**. Verify the deployment on [testnet BscScan](https://testnet.bscscan.com): supply must be 0, paused must be true, no MINTER_ROLE must be granted, and admin must be correct.

## Mainnet release gates (all mandatory)

1. Publish and independently audit the **TON BLUEX escrow** and its withdrawal policy.
2. Build independently verifiable lock/mint and burn/unlock flows with finality rules, replay protection, nonce/idempotency storage, relayer recovery and reconciliation.
3. Use non-custodial or independently governed proof validation; manual `reportBacking` alone is insufficient.
4. Add a transparent reserve monitor and alert on any `BSC totalSupply > verified TON escrow` state.
5. Deploy behind reviewed multisig administration and with a tested emergency pause strategy.
6. Complete third-party security review, adversarial testnet testing, verified BscScan source, public risk disclosures, and a liquidity plan.
7. Require explicit mainnet approval after all prior gates pass. This testnet-only script cannot deploy to BSC mainnet.

**Do not market, sell, or list wBLUEX as a live bridged asset on the basis of this scaffold.**
