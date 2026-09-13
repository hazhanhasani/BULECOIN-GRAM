# BlueCoin (BLUEX)

BlueCoin (BLUEX) is a TON Jetton connected to the BlueTap game ecosystem.

## Mainnet contract

- Jetton Master: `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`
- Symbol: `BLUEX`
- Decimals: `9`
- Total supply: `100,000,000 BLUEX`
- Logo: `bluecoin-logo.png`

## Current project status

BlueTap currently uses off-chain Blue Points for gameplay. Direct BLUEX claiming is intentionally not enabled until distribution rules, anti-abuse controls, wallet settlement and supply/admin finalization are complete.

See [TOKENOMICS.md](TOKENOMICS.md) for the current distribution design draft.

## On-chain audit

The repository includes a `BLUEX On-chain Audit` GitHub Action. It queries TONAPI and TON Center, validates the token identity and the expected fixed initial supply, and stores the raw public audit response as a short-lived workflow artifact.

Before any irreversible admin/supply action, run the audit again and verify metadata, supply and admin state.
