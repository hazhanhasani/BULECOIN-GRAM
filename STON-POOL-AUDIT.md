# BLUEX / GRAM STON.fi Pool Snapshot

Audit time: 2026-09-13 19:57 UTC

Official STON.fi API endpoint queried: `/v1/pools/EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX`

## Pool

- Pool address: `EQAJTo3VcLriSaMj-HdTzeEX6NJoQCyzG59bdvMW0k9956WX`
- DEX major version: 2
- Deprecated: false
- Token 0: native TON/GRAM pseudo-address `EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9c`
- Token 1: BLUEX Jetton Master `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`

## Current reserves

- GRAM reserve: `6,200,000,000` nano units = **6.2 GRAM**
- BLUEX reserve: `830,376,153,301` base units at 9 decimals = **830.376153301 BLUEX**
- Pool ratio: about **133.9316376 BLUEX per 1 GRAM**
- Inverse ratio: about **0.0074664957 GRAM per 1 BLUEX**

## Current liquidity / activity reported by STON.fi

- LP total value reported by API: about **$16.8894**
- 24h volume reported by API: about **$0.2720**
- LP fee: `20` basis-unit setting returned by API
- Protocol fee: `10` basis-unit setting returned by API
- Pool tags include `pool:dex_major_version:2` and `pool:liquidity:no`

At the API-reported pool valuation, the implied GRAM value is about **$1.3620**, which implies an instantaneous reserve-ratio BLUEX value of about **$0.01017 per BLUEX**. This is not a robust market valuation because the pool is extremely small; modest trades can materially move the reserve ratio.

## Pricing implication

A balanced liquidity addition preserves the existing reserve ratio; it does not reset the price. At the current ratio, adding 1 GRAM in balanced form would require about **133.93 BLUEX** and would leave the implied BLUEX price essentially unchanged.

If the intended launch reference is `$0.001/BLUEX`, the existing pool ratio is roughly 10.17x higher than that target. Repricing should therefore be treated as a pool-reconfiguration decision rather than simply adding more balanced liquidity.
