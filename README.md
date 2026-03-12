# PEX: A Decentralized Synthetic Primitive for the Peruvian Sol

## Overview

PEX is a decentralized finance (DeFi) primitive implemented on the Stacks blockchain, designed to provide a synthetic representation of the Peruvian Sol (PEN). Unlike collateral-backed stablecoins that rely on reserve custody, PEX utilizes a **non-redeemable, one-way burn-to-mint mechanism** governed by multi-oracle consensus.

This protocol is engineered to provide a robust, programmable digital asset that mirrors the local unit of account in Peru, facilitating decentralized liquidity and composable financial utility without reliance on centralized custodians or redemption-run vulnerabilities.

## Core Architectural Principles

* **Synthetic Abstraction:** PEX does not hold reserves. Its value is derived from oracle-fed price discovery, ensuring the token maintains a synthetic peg to the PEN.
* **One-Way Issuance (Burn-to-Mint):** New PEX is minted exclusively by burning designated collateral at the prevailing exchange rate. There is no redemption mechanism, which fundamentally eliminates the risk of protocol-level bank runs.
* **Oracle Consensus:** Price inputs are managed via a multi-oracle system to mitigate manipulation and ensure accurate tracking of the PEN/collateral exchange rate.
* **Composability:** As a DeFi primitive, PEX is designed to be integrated into broader smart contract ecosystems, allowing for trustless lending, automated remittance, and synthetic yield-bearing instruments.

## Why the Peruvian Sol (PEN)?

The PEN is an optimal testbed for this synthetic primitive due to its:

1. **Macroeconomic Stability:** Historically maintained within a tight inflation target (1–3%) by the Central Reserve Bank of Peru.
2. **Market Liquidity:** High domestic utilization makes it a critical unit of account for local trade and remittances.
3. **Resilience Testing:** By deploying in a market with distinct commodity-cycle sensitivities, the protocol can be stress-tested for robustness in real-world scenarios, providing a blueprint for synthetic primitives in other emerging markets.

## Repository Structure

* `/contracts`: Clarity smart contracts for the PEX minting and oracle integration logic.
* `/oracles`: Scripts and configurations for the multi-oracle consensus mechanism.
* `/docs`: Technical specifications, security analysis, and mathematical proofs of the synthetic model.
* `/tests`: Unit and integration tests covering edge-case scenarios for the burn-to-mint cycle.

## Disclaimer

*This project is currently in an experimental phase. PEX is a synthetic asset and does not represent a claim on any physical currency or centralized reserve. Users and developers should review the oracle security model and secondary market dynamics before integrating PEX into production-grade systems.*

## License

[MIT](LICENSE)
