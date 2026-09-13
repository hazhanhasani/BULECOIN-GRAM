# BLUEX On-chain Audit Snapshot

Final post-revocation audit: 2026-09-13 19:49 UTC

Sources: direct TON Center contract get-method calls plus TONAPI indexer confirmation.

## Identity

- Jetton Master: `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`
- Raw address: `0:947208b54f4cd23af44820ce2e723f37188db1a93c6b2e1680970687f2d3b0f6`
- Name: `BlueCoin`
- Symbol: `BLUEX`
- Decimals: `9`
- Description: `BlueCoin (BLUEX) is a community-driven digital token built on the TON blockchain, designed for fast, low-cost and secure transactions.`

## Final supply and control state

- Raw total supply: `100000000000000000`
- Human-readable supply: `100,000,000 BLUEX`
- Direct `get_jetton_data` mintability value: `0`
- Direct `get_jetton_data` admin value: empty / no admin
- `get_next_admin_address`: empty
- TONAPI `mintable`: `false`
- TONAPI holders count at audit time: `3`
- TONAPI verification: `none`

**Ownership has been revoked. There is no privileged admin and additional BLUEX can no longer be minted. The final supply is capped at 100,000,000 BLUEX.**

## Final metadata

- Image: `https://raw.githubusercontent.com/hazhanhasani/BULECOIN-GRAM/main/bluecoin-logo.png`
- Name: `BlueCoin`
- Symbol: `BLUEX`
- Decimals: `9`

The metadata cleanup was completed before ownership revocation.

## Remaining launch work

Ownership/supply finalization is complete. Remaining work is market-facing rather than contract-admin work:

1. Choose the launch price / initial pool ratio.
2. Choose the amount of initial liquidity and pair asset.
3. Create or rebalance the intended DEX liquidity pool.
4. Complete token verification/listing processes where applicable.

Because ownership is revoked, contract-admin metadata changes and additional minting are no longer available.
