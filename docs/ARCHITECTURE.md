# PEX Architecture Overview

## System Components

### 1. **PEX Token Contract** (`pex-token.clar`)
- SIP-010 compliant fungible token
- Tracks total supply, mints, and burns
- Owned by contract deployer
- Decimals: 8 (like BTC)

**Key Functions:**
- `mint(amount, recipient)` - Called by burn-to-mint contract
- `burn(amount)` - User-initiated token burn
- `get-balance(owner)` - Query balance
- `get-total-supply()` - Query total supply

### 2. **Oracle Consensus Contract** (`pex-oracle.clar`)
- Multi-oracle system with 2-of-3 consensus
- Tracks oracle reputation and activity status
- Maintains price feeds for collateral types
- Implements price deviation validation

**Key Functions:**
- `register-oracle(address)` - Admin registers oracles
- `submit-price(collateral, price, timestamp)` - Oracle submits price
- `get-price(collateral)` - Query consensus price

### 3. **Burn-to-Mint Contract** (`pex-burn-to-mint.clar`)
- Implements the core one-way burn mechanism
- Burns STX collateral to mint PEX
- Records all burn events
- Admin can pause burns for maintenance

**Key Functions:**
- `burn-to-mint(collateral-amount)` - User burns STX for PEX
- `set-burn-pause(paused)` - Admin pause/unpause
- `get-burn-event(id)` - Query burn history

## Data Flow

```
User → burn-to-mint contract → burn STX
                              ↓
                        oracle.get-price()
                        (consensus from 2+ oracles)
                              ↓
                        calculate PEX amount
                              ↓
                        pex-token.mint()
                              ↓
User receives PEX
```

## Oracle Consensus Mechanism

The system uses a 2-of-3 oracle consensus:

1. Three independent oracles submit price feeds
2. Contract calculates consensus price (median)
3. Price is validated against deviation threshold (1%)
4. If consensus fails, transaction reverts
5. Oracle reputation scores tracked for incentive alignment

## Security Considerations

- **No Redemption:** One-way burn-to-mint eliminates bank-run scenarios
- **Oracle Redundancy:** 2-of-3 consensus prevents single-oracle manipulation
- **Price Deviation Checks:** Limits flash crash exploitation
- **Pause Mechanism:** Admin can halt operations during emergency
- **Event Logging:** All burns recorded for auditability

## Deployment Order

1. Deploy `pex-oracle.clar` first (other contracts depend on it)
2. Deploy `pex-token.clar` (burn-to-mint depends on it)
3. Deploy `pex-burn-to-mint.clar` last
4. Register oracles in oracle contract
5. Set contract references in all contracts

## Testing Strategy

- Unit tests for each contract in isolation
- Integration tests for inter-contract calls
- Fuzzing tests for edge cases (overflow, underflow)
- Oracle consensus failure scenarios
- High-volume burn simulation
