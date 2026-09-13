# BLUEX On-chain Audit Snapshot

Audit time: 2026-09-13 19:04 UTC

Sources queried by GitHub Actions: TONAPI and TON Center.

## Identity

- Jetton Master: `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`
- Raw address: `0:947208b54f4cd23af44820ce2e723f37188db1a93c6b2e1680970687f2d3b0f6`
- Name: `BlueCoin`
- Symbol: `BLUEX`
- Decimals: `9`
- Description: `BlueCoin (BLUEX) is a community-driven digital token built on the TON blockchain, designed for fast, low-cost and secure transactions.`

## Supply and control

- Raw total supply: `100000000000000000`
- Human-readable supply at 9 decimals: `100,000,000 BLUEX`
- Mintable: `true`
- Admin address: `EQDdaNA_KZUkYSqH9HFBG8amOX1QukRsIVPHPwD3qG4RKX7U`
- TONAPI holders count: `3`
- TONAPI verification: `none`

## Metadata observation

Current image URL returned by both APIs:

`https://raw.githubusercontent.com/hazhanhasani/BULECOIN-GRAM/main/bluecoin-logo.png?utm_source=chatgpt.com`

The image resolves to the intended repository logo, but the tracking query string should be removed from final on-chain metadata before irreversible admin revocation. Preferred clean URL:

`https://raw.githubusercontent.com/hazhanhasani/BULECOIN-GRAM/main/bluecoin-logo.png`

## Current blockers before final supply lock

1. `mintable` is still `true`; the contract is not yet in its intended final no-future-mint state.
2. TONAPI verification is `none`; asset-registry / wallet verification work remains.
3. Final metadata should be cleaned before relinquishing admin control.
4. Distribution wallets and the BlueTap claim design should be finalized and tested before any irreversible admin action.

No irreversible on-chain action was performed by this audit.
