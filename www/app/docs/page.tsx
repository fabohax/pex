import Link from "next/link";

export default function DocsPage() {
  return (
    <div className="min-h-screen bg-[#0b0f18] text-[#e5e7eb]">
      <main className="mx-auto grid w-full max-w-6xl gap-8 px-4 py-10 md:grid-cols-[220px_1fr] md:px-8">
        <aside className="sticky top-5 hidden h-[calc(100vh-2.5rem)] overflow-y-auto rounded-none border border-[#334155] bg-[#111827] p-4 text-sm text-[#cbd5e1] md:block">
          <p className="mb-3 text-xs uppercase tracking-[0.2em] text-[#94a3b8]">Contents</p>
          <nav className="space-y-2">
            <a href="#overview" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Overview</a>
            <a href="#why" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Why PEX</a>
            <a href="#design" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Design principles</a>
            <a href="#model" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Issuance model</a>
            <a href="#stacks" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Stacks features</a>
            <a href="#pricing" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Pricing & Oracle</a>
            <a href="#safety" className="block rounded px-2 py-1 text-[#f8fafc] hover:bg-[#1e293b] hover:text-[#60a5fa]">Safety caps</a>
          </nav>
        </aside>

        <section className="space-y-8">
          <header className="mb-6 rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-xs uppercase tracking-[0.22em] text-[#94a3b8]">PEX docs</p>
            <h1 className="mt-2 text-3xl font-bold text-white md:text-4xl">PEX Synthetic Primitive</h1>
            <p className="mt-2 max-w-3xl text-base text-[#cbd5e1] md:text-lg">
              A concise technical reference for the PEX synthetic primitive design.
            </p>
          </header>

          <section id="overview" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Overview</p>
            <h2 className="mt-2 text-2xl font-bold text-white">PEX: PEN synthetic DeFi primitive</h2>
            <p className="mt-3 text-[#dbeafe] leading-7">
              PEX is a synthetic decentralized finance primitive implemented on the Stacks blockchain. It is modeled as a single-purpose smart-contract system that mints a PEN-tracking synthetic token in a one-way burn-to-mint flow.
            </p>
            <p className="mt-2 text-[#dbeafe] leading-7">
              The protocol addresses reserve-custody risk by avoiding centralized collateral custody and eliminates redemption-run risk by making tokens non-redeemable on demand. Instead, it relies on deterministic algorithmic redemption math and settlement finalized through an oracle-based consensus.
            </p>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Key properties:
            </p>
            <ul className="mt-2 list-disc pl-6 text-[#cbd5e1] leading-7">
              <li>One-way issuance: users burn approved collateral and receive PEX tokens at a deterministic rate.</li>
              <li>Price reference: PEX is designed to track PEN using a weighted oracle feed and market price mechanism.</li>
              <li>Composable on Stacks: tokens can be used in liquidity pools, swaps, and other DeFi primitives without centralized custody.</li>
            </ul>
          </section>

          <section id="why" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Problem</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Why PEX synthetic primitive</h2>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Traditional stablecoins depend on reserves and redemption, which introduce custody and liquidity run risks. PEX decouples synthetic value issuance from redemption by using on-chain collateral math and deterministic minting.
            </p>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Because PEX does not support direct redemption, risks are controlled through protocol-level caps, collateral ratio checks, and oracle finalization logic. This shifts risk management to programmable rules rather than off-chain liquidity guarantees.
            </p>
            <ul className="mt-3 list-disc pl-6 text-[#cbd5e1]">
              <li><strong>Robust oracle-based pricing:</strong> multiple feed sources with validity and staleness checks.</li>
              <li><strong>Deterministic mechanics:</strong> Burn-to-mint formulas are fixed and verifiable.
</li>
              <li><strong>Composability:</strong> PEX tokens are designed as modular assets for liquidity and swaps.</li>
            </ul>
          </section>

          <section id="design" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Design</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Design principles</h2>
            <div className="mt-3 text-[#dbeafe] leading-7 space-y-2">
              <p><strong>1) Primitive-first:</strong> PEX views the synthetic token as a protocol-native primitive with fixed behavior and invariant rules. This makes reasoning easier and integration more predictable.</p>
              <p><strong>2) One-way issuance:</strong> Collateral burns enable minting; there is no symmetric redemption path. This minimizes liquidity run vectors and simplifies risk controls.</p>
              <p><strong>3) Deterministic math:</strong> Mint and settlement formulas are deterministic, on-chain, and verifiable, enabling audits and testability.</p>
              <p><strong>4) Oracle-backed finalization:</strong> PEX derives value from multi-source oracle consensus with stale-data protection and finalization windows for settlement consistency.</p>
              <p><strong>5) On-chain governance risk controls:</strong> Issuance caps, CR limits, and fee parameter updates are controlled by governance with timelocks and explicit update procedures.</p>
            </div>
          </section>

          <section id="model" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Model</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Issuance model</h2>
            <p className="mt-2 text-[#dbeafe] leading-7">
              PEX issues synthetic tokens using a one-way mint process: users lock collateral (e.g. STX or other approved asset), trigger the burn operation, and receive exactly calculated PEX tokens.
            </p>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Core steps:
            </p>
            <ol className="mt-2 list-decimal pl-6 text-[#cbd5e1] leading-7">
              <li>User submits collateral and calls `mint` with desired amount.</li>
              <li>Contract fetches current oracle price and applies deterministic mint formula plus fees.</li>
              <li>Collateral is burned/locked, PEX tokens are minted to user wallet.</li>
              <li>Protocol updates total supply and collateral ratio state variables.</li>
            </ol>
            <div className="mt-3 rounded-lg border border-[#1f2937] bg-[#0f172a] p-3 text-sm text-[#cbd5e1]">
              <p className="font-semibold text-[#f8fafc]">Core formulas</p>
              <ul className="mt-2 list-disc pl-5">
                <li>mintAmount = floor(collateralAmount * (1 - mintFee) / price)</li>
                <li>totalCollateral = totalCollateral + collateralAmount</li>
                <li>collateralRatio = totalCollateral / totalPEXSupply</li>
              </ul>
            </div>
          </section>

          <section id="stacks" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Stacks</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Stacks technical features</h2>
            <p className="mt-2 text-[#dbeafe] leading-7">
              PEX is implemented on Stacks to leverage Clarity&apos;s deterministic smart contracts and Bitcoin settlement security via Proof of Transfer (PoX).
              The architecture is designed for composability with Stacks DeFi patterns while keeping execution semantics simple and auditable.
            </p>
            <ul className="mt-3 list-disc pl-6 text-[#dbeafe] leading-7">
              <li><strong>Clarity contracts:</strong> deterministic evaluation, no Turing loops, and explicit data types make PEX behavior precisely predictable and audit-friendly.</li>
              <li><strong>PoX anchoring:</strong> PEX state transitions are anchored on Bitcoin through Stacks blocks, providing a high-assurance settlement layer for value finality.</li>
              <li><strong>Multi-oracle integration:</strong> PEX miners/oracle registries provide signed feeds; the contract aggregates and validates against staleness thresholds.</li>
              <li><strong>Governance and timelock controls:</strong> risk parameters (fees, issuance caps, CR floors) are controlled by governance contracts and require a delay before activation.</li>
              <li><strong>Composable asset flows:</strong> minted PEX tokens can be used in liquidity pools, AMMs, and other Stacks dapps for arbitrage and utility without centralized custody dependencies.</li>
            </ul>
          </section>

          <section id="pricing" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Pricing</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Pricing and oracle</h2>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Pricing uses an oracle pipeline: each mint/burn query the latest valid weighted price and applies protocol fees and slippage adjustment.
              The protocol enforces a price validity window and rejects stale data to avoid price manipulation.
            </p>
            <ul className="mt-3 list-disc pl-6 text-[#cbd5e1] leading-7">
              <li><strong>Oracle aggregation:</strong> combines multiple trusted data sources into a single derived price using median and weighting rules.</li>
              <li><strong>Staleness protection:</strong> data older than N blocks is rejected, and fallback paths are defined for missing feeds.</li>
              <li><strong>Dynamic slippage model:</strong> in high-utilization scenarios, mint/burn slippage scales to maintain collateral ratio stability.
</li>
            </ul>
            <div className="mt-3 rounded-lg border border-[#1f2937] bg-[#0f172a] p-3 text-sm text-[#cbd5e1]">
              <p className="font-semibold text-[#f8fafc]">Pricing formula</p>
              <p className="mt-1 text-[#dbeafe] leading-6">mintPrice = oraclePrice * (1 + protocolFee + utilizationSlippage)</p>
            </div>
          </section>

          <section id="safety" className="rounded-none border border-[#334155] bg-transparent p-5">
            <p className="text-[0.7rem] uppercase tracking-[0.2em] text-[#94a3b8]">Safety</p>
            <h2 className="mt-1 text-2xl font-bold text-white">Safety and risk caps</h2>
            <p className="mt-2 text-[#dbeafe] leading-7">
              Safety is enforced by multiple on-chain guardrails that run at the protocol level, not by off-chain liquidity backstops.
              This includes parameterized caps, collateral checks, and fallback procedures for oracle failures.
            </p>
            <ul className="mt-3 list-disc pl-6 text-[#dbeafe] leading-7">
              <li><strong>Per-asset issuance caps:</strong> limit how much PEX can be minted per collateral type to avoid concentration risk.</li>
              <li><strong>Global open interest limit:</strong> caps total supply to keep collateralization within safe bounds.</li>
              <li><strong>Collateral ratio enforcement:</strong> each mint and burn validates that resulting CR stays above the minimum threshold.</li>
              <li><strong>Emergency pause and governance:</strong> protocol can pause new issuance and parameter updates via timelocked governance in abnormal events.</li>
            </ul>
          </section>

          <section className="rounded-none border border-[#334155] bg-transparent p-5 text-sm text-[#cbd5e1]">
            <p className="font-semibold text-white">Next steps</p>
            <ol className="mt-2 list-decimal pl-5 text-[#dbeafe]">
              <li>Review contract spec and Clarity implementation details.</li>
              <li>Build integration tests for mint/burn and oracle behavior.</li>
              <li>Document pool economics and on-chain risk parameter flows.</li>
            </ol>
            <div className="mt-4 text-sm">
              <Link href="/" className="text-[#60a5fa] hover:text-[#93c5fd] font-semibold text-xs">← BACK HOME</Link>
            </div>
          </section>
        </section>
      </main>
    </div>
  );
}
