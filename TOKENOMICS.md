# BlueCoin (BLUEX) Tokenomics — Draft v0.1

> Status: design draft. No irreversible on-chain action should be taken from this document alone.

## Fixed supply

- Token: BlueCoin
- Symbol: BLUEX
- Network: TON
- Jetton Master: `EQCUcgi1T0zSOvRIIM4ucj83GI2xqTxrLhaAlwaH8tOw9oTJ`
- Decimals: 9
- Total supply: 100,000,000 BLUEX

## Proposed allocation

| Allocation | Share | BLUEX | Purpose |
|---|---:|---:|---|
| BlueTap player rewards | 50% | 50,000,000 | Mining seasons, gameplay, quests and verified referrals |
| Liquidity | 20% | 20,000,000 | DEX liquidity and market depth |
| Ecosystem & partnerships | 10% | 10,000,000 | Integrations, partners, developer/community ecosystem |
| Treasury & operations | 8% | 8,000,000 | Long-term project operations and infrastructure |
| Team | 5% | 5,000,000 | Team allocation, intended to be vested rather than immediately liquid |
| Marketing & community campaigns | 5% | 5,000,000 | Community growth, campaigns and events |
| Security & bug bounty reserve | 2% | 2,000,000 | Security reviews, bug bounties and emergency incentives |
| **Total** | **100%** | **100,000,000** | |

## BlueTap distribution model

Blue Points are an off-chain game score and should not be treated as a permanently fixed 1:1 or fixed-rate promise for BLUEX. A fixed conversion rate would let game inflation drain the finite token supply.

Recommended model: each season has a capped BLUEX reward pool. Eligible Blue Points determine each player's share of that pool after anti-abuse checks.

`user_BLUEX = season_BLUEX_pool × user_eligible_points / total_eligible_points`

This keeps issuance bounded even if BlueTap activity grows sharply.

### Season eligibility

Before a claim is accepted, the system should verify at least:

- a connected TON wallet;
- Telegram-signed identity;
- one reward identity per Telegram account;
- referral self-invite and obvious farming protections;
- server-authoritative tap, auto-mine and reward history;
- minimum account age/activity requirements;
- per-season snapshot/finalization so historical scores cannot change after settlement;
- idempotent claims so the same allocation cannot be claimed twice.

## Claim architecture

1. BlueTap records gameplay as Blue Points only.
2. At season close, the server freezes an eligibility snapshot.
3. Anti-abuse checks produce `eligible_points`.
4. A fixed season BLUEX pool is distributed proportionally.
5. Each user's claim allocation is stored server-side with an immutable claim identifier.
6. User connects a TON wallet and submits the claim.
7. The backend/distributor verifies that the claim is unused before transferring BLUEX.
8. Claim transaction hash and amount are recorded for reconciliation.

The first production claim should use a small capped pool until the complete flow has been tested with real wallets.

## Supply lock / admin plan

Current metadata, distribution wallets and operational process must be finalized before admin rights are revoked. The intended final state is a capped supply with no future minting capability while retaining burn support where supported by the Jetton wallet implementation.

Do **not** revoke or burn admin control until:

- metadata and logo URLs are final;
- distribution and treasury wallet structure is final;
- claim/distributor flow has been tested;
- no required contract-level metadata change remains;
- a fresh on-chain audit confirms the expected supply and administrator.

## Next engineering milestones

- Create dedicated allocation wallets / accounting for community, liquidity, treasury, team and ecosystem buckets.
- Add a season settlement table to BlueTap.
- Add claim eligibility and anti-abuse checks.
- Implement TON distributor/claim service with idempotency and reconciliation.
- Test end-to-end on TON testnet or with a deliberately small production tranche.
- Only after final verification, disable future minting / revoke admin according to the Jetton contract's supported mechanism.
