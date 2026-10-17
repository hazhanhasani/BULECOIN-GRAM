# BlueCoin (BLUEX) — Verification Evidence

Last reviewed: 2026-10-17. This document compiles links and **historical** findings; it is not a claim that every on-chain value was independently rechecked on this date.

## 1. Token identity

| Field | Value |
| --- | --- |
| Name | BlueCoin |
| Symbol | BLUEX |
| Blockchain | TON mainnet |
| Jetton master | `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ` |
| Decimals | 9 |
| Supply at finalization | 100,000,000 BLUEX |
| Official image | [Direct PNG](https://raw.githubusercontent.com/hazhanhasani/BULECOIN-GRAM/main/bluecoin-logo.png) |

Independent inspection entry point: [Tonviewer — Jetton master](https://tonviewer.com/EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ).

## 2. Contract-control and supply evidence

The project published a [post-revocation on-chain audit snapshot](AUDIT.md) on **2026-09-13**. It records:

- `get_jetton_data` reported mintability `0` and no administrator;
- `get_next_admin_address` returned no next administrator;
- TONAPI reported `mintable: false`;
- final human-readable supply: 100,000,000 BLUEX at 9 decimals.

See the [GitHub Actions on-chain audit workflow](.github/workflows/bluex-audit.yml) and its [recorded runs](https://github.com/hazhanhasani/BULECOIN-GRAM/actions/workflows/bluex-audit.yml) for reproducible evidence. **The workflow and AUDIT.md are project-maintained technical checks, not a third-party security audit or formal verification by Tonkeeper.** Recheck current blockchain state before relying on these historical findings.

## 3. Market and liquidity

There is a documented [STON.fi V2 pool](https://app.ston.fi/pools/EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX) with pool address:

`EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX`

The [pool snapshot](STON-POOL-AUDIT.md) from **2026-09-13** reported approximately **$16.89 in total liquidity**; this is extremely shallow liquidity and **not evidence of a mature or stable market**. Historical reserves and ratios must not be presented as current prices or current market conditions. The [pool audit workflow](.github/workflows/ston-pool-audit.yml) can be manually rerun.

## 4. Public infrastructure and ecosystem

- [Official website source](site/) and [public website](https://hazhanhasani.github.io/BULECOIN-GRAM/).
- [BlueCoin Telegram channel](https://t.me/bluecoinx).
- [BlueTap Telegram Mini App source](https://github.com/hazhanhasani/blueTap): React/Vite frontend, Cloudflare Worker backend, D1, Telegram-signed `initData` verification, server-side gameplay rate limiting and TON Connect wallet UI.
- [BlueTap bot](https://t.me/bluecoinxbot).
- [BlueTap deployment documentation](https://github.com/hazhanhasani/blueTap/blob/main/docs/SETUP_FA.md) describes a Worker-hosted Mini App. Deployment documentation is not proof of current uptime.

**BlueTap currently awards off-chain Blue Points, not on-chain BLUEX.** The actual token claim path is disabled until safe treasury custody, wallet ownership proofs, anti-abuse and capped season allocations are implemented. There is no guaranteed redemption rate.

[Tokenomics](TOKENOMICS.md) is a **draft**, not a finalized token distribution commitment.

## 5. Verification / review transparency

- Previous asset-list submission: [tonkeeper/ton-assets PR #6222](https://github.com/tonkeeper/ton-assets/pull/6222), closed without merge on **2026-09-16**.
- The maintainer stated that verification may be declined without further explanation. This is acknowledged and respected.
- **BLUEX has not been verified by Tonkeeper based on that PR.** The existence of metadata, a pool, or a submitted PR does not imply approval, investment safety or endorsement.

The project requests only an accurate, independently inspectable identity listing and welcomes corrections. No payment or preferential treatment is requested.
