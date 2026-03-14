# PEX Protocol Specification

## 1. Overview

PEX (Peruvian Exchange Token) is a **non-redeemable, synthetic primitive** for the Peruvian Sol (PEN) implemented on the Stacks blockchain using Clarity smart contracts.

**Key Characteristics:**
- **Synthetic:** Value derived from oracle consensus, not collateral backing
- **Non-Redeemable:** One-way burn-to-mint, no redemption mechanism
- **Decentralized:** Multi-oracle consensus with 2-of-3 threshold
- **Composable:** DeFi primitive for lending, swaps, and remittances

## 2. Core Mechanism: Burn-to-Mint

### Supply Issuance

```
User → Burn(X STX) → Oracle Rate(PEN/STX) → Mint(Y PEX) → User Receives Y PEX
```

Users burn STX collateral to receive PEX at the oracle-derived exchange rate:

```
PEX Amount = (STX Amount × Exchange Rate) / Price Decimals
```

### No Redemption

- **No redemption contract:** Users cannot return PEX for STX
- **Eliminates bank runs:** No race condition to exit
- **Asymmetric incentives:** Holder incentive is appreciation, not exit liquidity

## 3. Oracle Consensus

### Multi-Oracle Architecture

Three independent operators submit price feeds:

```
Oracle 1: Price = P₁, Timestamp = T₁
Oracle 2: Price = P₂, Timestamp = T₂
Oracle 3: Price = P₃, Timestamp = T₃
```

### Consensus Rule

- **Quorum:** 2 of 3 oracles must have valid prices
- **Deviation Check:** All prices within 1% (100 bps) of median
- **Freshness:** Prices no older than 10 minutes
- **Consensus Price:** Median of valid oracle prices

### Oracle Incentives

Possible extensions:
- Reputation score tracking
- Slashing for malicious reports
- Operator bond requirements
- Fee sharing from transaction volume

## 4. Economic Model

### Price Discovery

The PEX/STX rate reflects:

```
PEX/STX = PEN/USD / STX/USD
```

Where:
- **PEN/USD:** Official Central Reserve Bank rate or market consensus
- **STX/USD:** Market price from major exchanges

### Use Cases

1. **Remittances:** Peruvian diaspora → PEX → PEN settlements
2. **Synthetic Exposure:** Trade PEN without direct banking access
3. **Collateral:** Use PEX in DeFi lending protocols
4. **Unit of Account:** Price goods/services in PEX locally

## 5. Security Model

### Attack Vectors & Mitigations

| Attack | Vector | Mitigation |
|--------|--------|-----------|
| Oracle Manipulation | Single oracle reports false price | 2-of-3 consensus + deviation check |
| Flash Loan | Exploit temporary price spike | Frequent oracle updates, slippage controls |
| Bank Run | Redemption race | No redemption mechanism |
| Collateral Depletion | Contract runs out of collateral | N/A (synthetic asset) |
| Double Spend | Blockchain reorg | Stacks PoX consensus |

### Smart Contract Safeguards

- **Minimum burn amount:** Prevent dust attacks
- **Pause mechanism:** Admin can halt burns during emergency
- **Price bounds:** Reject prices outside reasonable range
- **Event logging:** Immutable audit trail of all burns

## 6. Governance

### Current (v0.1)

- Single contract owner controls:
  - Oracle registration/removal
  - Pause/unpause mechanism
  - Parameter tuning (minimum burn, decimals)

### Future (v1.0)

Potential upgrades:
- DAO governance for oracle management
- Community voting on parameter changes
- Decentralized oracle operator selection
- Fee routing mechanisms

## 7. Mathematical Properties

### Synthetic Peg

For PEX to maintain PEN parity:

$$\text{PEX/STX} = \frac{\text{PEN/USD}}{\text{STX/USD}}$$

The protocol does not enforce this peg (unlike collateralized stablecoins). Instead, market participants are incentivized to maintain it through:

1. **Arbitrage:** If PEX > PEN equivalent, burn STX to mint PEX
2. **Hedging:** If PEX < PEN equivalent, use alternative assets

### Collateral Efficiency

- **Collateral requirement:** 0% (synthetic)
- **Capital efficiency:** 100% (all STX burned, all PEX minted)
- **Leverage:** Unlimited in theory (no collateral constraints)

## 8. Specification Tests

### Test Case 1: Basic Burn-to-Mint
```
Input: Burn 1 STX (1,000,000 satoshis)
Oracle Rate: PEN/STX = 0.5 (theoretical)
Expected Output: 500,000 PEX
```

### Test Case 2: Oracle Consensus Failure
```
Oracle 1: Price = 500,000
Oracle 2: Price = 499,000
Oracle 3: Price = 700,000  (>1% deviation)
Result: Consensus fails, transaction reverts
```

### Test Case 3: Stale Price Rejection
```
Last Price Update: 15 minutes ago
Timeout Threshold: 10 minutes
Result: Price marked stale, consensus fails
```

## 9. Deployment Checklist

- [ ] Deploy oracle contract
- [ ] Register 3 oracle operators
- [ ] Deploy token contract
- [ ] Deploy burn-to-mint contract
- [ ] Verify oracle price submissions
- [ ] Load test with high burn volume
- [ ] Security audit (external firm)
- [ ] Mainnet deployment

## 10. Future Enhancements

### Phase 1 (Current)
- Burn-to-mint mechanism
- Oracle consensus
- Basic governance

### Phase 2
- Secondary market liquidity pools
- Lending protocols with PEX collateral
- Yield farming mechanisms
- Cross-chain bridges

### Phase 3
- Decentralized oracle network
- Governance DAO
- Dynamic fee structures
- Multi-currency synthetic primitive
