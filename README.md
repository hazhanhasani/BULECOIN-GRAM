# BlueCoin (BLUEX)

BlueCoin (BLUEX) is a fixed-supply TON Jetton with public liquidity on STON.fi.

## Mainnet

- Jetton Master: `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`
- Symbol: `BLUEX`
- Decimals: `9`
- Final supply: `100,000,000 BLUEX`
- Minting: permanently disabled
- Ownership/admin: revoked
- STON.fi V2 pool: `EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX`

## Verification

Tonkeeper asset verification is currently under review in [ton-assets PR #6222](https://github.com/tonkeeper/ton-assets/pull/6222).

## Website

The official static website source is in [`site/`](site/) and is deployed through GitHub Pages using `.github/workflows/pages.yml`.

The site includes live STON.fi pool reserve/ratio data with an on-chain snapshot fallback, the official Jetton Master, audit links, and the current verification status.

## Audits

- [Final BLUEX on-chain audit](AUDIT.md)
- [STON.fi pool audit](STON-POOL-AUDIT.md)
- GitHub Actions workflows continuously provide reproducible public checks.

## Tokenomics

`TOKENOMICS.md` remains a planning document. Detailed allocation and utility should be treated as draft until explicitly finalized and published.
