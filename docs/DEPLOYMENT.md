# PEX Deployment Guide

## Prerequisites

- Clarinet CLI installed (`brew install clarinet` or from https://github.com/hirosystems/clarinet)
- Stacks testnet wallet with STX balance
- Node.js 16+ for running helper scripts

## Installation

```bash
# Install Clarinet
brew install clarinet

# Or using npm
npm install -g @hirosystems/clarinet
```

## Configuration

### 1. Set Environment Variables

Copy `.env.example` to `.env.local` and fill in values:

```bash
cp .env.example .env.local
```

Edit `.env.local` with:
- Your wallet mnemonic
- Your deployer address
- Oracle addresses
- Network settings

### 2. Validate Contracts

```bash
clarinet check
```

This validates syntax and type checking across all contracts.

### 3. Run Tests

```bash
clarinet test
```

Runs all test files in the `tests/` directory.

## Deployment to Testnet

### Step 1: Start Local Testing

```bash
clarinet integrate
```

This launches a local Stacks blockchain with your contracts deployed.

### Step 2: Deploy to Testnet

```bash
# Set network to testnet in Clarinet.toml (already configured)

# Run deployment
clarinet deploy --network testnet
```

Deployment will:
1. Deploy `pex-oracle.clar`
2. Deploy `pex-token.clar`
3. Deploy `pex-burn-to-mint.clar`

### Step 3: Initialize Contracts

After deployment, run initialization:

```bash
# Initialize token metadata
clarinet invoke pex_token initialize_token "PEX Synthetic Sol" "PEX" u8

# Register oracles
clarinet invoke pex_oracle register_oracle SP2XXXXXXXXX
clarinet invoke pex_oracle register_oracle SP2YYYYYYYYY
clarinet invoke pex_oracle register_oracle SP2ZZZZZZZZZ

# Start oracle price submissions (see oracle scripts)
```

## Post-Deployment Operations

### Submitting Price Feeds

Oracle operators can submit prices:

```bash
clarinet invoke pex_oracle submit_price "STX" u500000 block_height
```

### User Burn-to-Mint Operations

Users can burn STX for PEX:

```bash
clarinet invoke pex_burn_to_mint burn_to_mint u1000000
```

This burns 1 STX and receives PEX at oracle rate.

### Monitoring

```bash
# Check contract state
clarinet console

# In console:
(contract-call? pex-token get-balance tx-sender)
(contract-call? pex-oracle get-price "STX")
(contract-call? pex-burn-to-mint get-total-collateral-burned)
```

## Troubleshooting

### Contract Won't Deploy

- Verify Clarinet.toml syntax
- Run `clarinet check` for errors
- Check wallet has sufficient balance

### Oracle Price Submission Failing

- Verify oracle registered: `get-oracle-info`
- Check timestamp is recent
- Ensure consensus threshold met

### Burn-to-Mint Not Working

- Verify oracles have submitted prices
- Check user has STX balance
- Ensure burn not paused: `get-is-paused`

## Next Steps

1. Monitor oracle consensus health
2. Gather usage metrics
3. Iterate on oracle consensus algorithm
4. Plan mainnet upgrade path
