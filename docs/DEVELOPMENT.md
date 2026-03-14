# PEX Development Setup Guide

## Quick Start

### 1. Clone Repository
```bash
cd /home/fabohax/Documents/pex
```

### 2. Install Clarinet

**macOS:**
```bash
brew install clarinet
```

**Linux (Ubuntu/Debian):**
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.5.4/clarinet-linux-x64-glibc.tar.gz | tar xz
sudo mv clarinet /usr/local/bin/
```

**From Source:**
```bash
git clone https://github.com/hirosystems/clarinet.git
cd clarinet
cargo build --release
```

### 3. Setup Local Environment

```bash
# Copy environment template
cp .env.example .env.local

# Create local Stacks configuration
mkdir -p .stacks
```

### 4. Validate Setup

```bash
# Check Clarinet installation
clarinet --version

# Validate all contracts
clarinet check

# View available tests
clarinet test --list
```

### 5. Run Local Development

```bash
# Start integrated testing environment
clarinet integrate

# In another terminal, run tests
clarinet test

# List available REPL commands
clarinet console
```

## Development Workflow

### Making Contract Changes

1. **Edit contract file** in `contracts/`
2. **Validate syntax:** `clarinet check`
3. **Run tests:** `clarinet test`
4. **Test in REPL:** `clarinet console`
5. **Deploy to testnet:** When ready

### Adding New Tests

1. Create test file in `tests/` directory
2. Use Clarinet test syntax (see existing tests)
3. Run: `clarinet test tests/test-*.clar`

### Contract Development Tips

- Use descriptive error codes in error messages
- Include inline comments for complex logic
- Test edge cases (overflow, zero amounts, etc.)
- Follow SIP standards (SIP-010 for tokens)
- Keep contracts modular and composable

## IDE Setup

### VS Code

1. Install "Clarity" extension by Stacks Foundation
2. Install "Even Better TOML" for Clarinet.toml editing
3. Add to `.vscode/settings.json`:

```json
{
  "[clarity]": {
    "editor.defaultFormatter": "hirosystems.clarity",
    "editor.formatOnSave": true
  },
  "[toml]": {
    "editor.defaultFormatter": "tamasfe.even-better-toml"
  }
}
```

### Vim/Neovim

Install clarity-lsp for LSP support:
```bash
cargo install clarity-lsp
```

## Testing Best Practices

- **Unit tests** for individual functions
- **Integration tests** for contract interactions
- **Fuzzing tests** for boundary conditions
- **Mock external calls** to oracles
- **Test error handling** explicitly

## Debugging

### Using REPL Console

```bash
clarinet console

# View contract state
(contract-call? pex-token get-total-supply)

# Simulate function call
(contract-call? pex-burn-to-mint burn-to-mint u1000000)

# Check oracle state
(contract-call? pex-oracle get-oracle-info tx-sender)
```

### View Logs

```bash
# Check integration test logs
tail -f .clarinet/log
```

## Resources

- [Clarity Documentation](https://docs.stacks.co/clarity)
- [SIP-010 Token Standard](https://github.com/stacksgov/sips/blob/main/sips/sip-010/sip-010-fungible-token-standard.md)
- [Clarinet GitHub](https://github.com/hirosystems/clarinet)
- [Stacks Discord](https://discord.gg/stacks)

## Troubleshooting

### "clarinet: command not found"
- Verify installation: `which clarinet`
- Add to PATH if needed: `export PATH="/path/to/clarinet:$PATH"`

### Contract validation fails
- Check syntax: `clarinet check --verbose`
- Review error messages
- Compare against working examples

### Tests not running
- Verify test file syntax: `clarinet test --list`
- Check function/contract references
- Ensure test files in `tests/` directory

## Contributing

1. Create feature branch
2. Make changes and test thoroughly
3. Submit PR with test coverage
4. Wait for code review
5. Merge to main

## Next Steps

- [ ] Set up local development environment
- [ ] Run existing tests
- [ ] Understand contract architecture
- [ ] Deploy to testnet
- [ ] Participate in oracle consensus
