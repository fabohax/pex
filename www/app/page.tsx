export default function Home() {
  return (
    <div className="min-h-screen bg-[#0d1117] text-[#edf1f8]">
      <main className="mx-auto flex min-h-screen w-full max-w-4xl flex-col justify-center px-6 py-12">
        <div className="mb-8 text-[10px] font-semibold uppercase tracking-[0.25em] text-[#9ca3af]">
          Synthetic Primitive • Seed-stage
        </div>

        <h1 className="text-5xl font-bold leading-[1.04] md:text-7xl">PEX</h1>
        <p className="mt-4 max-w-3xl text-base text-[#cbd5e1] md:text-lg">
          First one-way synthetic issuance and deterministic swaps for algorithmic asset exposure to the Peruvian Sol.
        </p>

        <div className="mt-8 grid w-full gap-3 sm:grid-cols-3">
          <div className="border border-[#374151] bg-[#111827] p-3">
            <p className="text-[10px] uppercase tracking-[0.2em] text-[#9ca3af]">Network</p>
            <p className="mt-1 text-xl font-semibold text-white">Stacks Testnet</p>
          </div>
          <div className="border border-[#374151] bg-[#111827] p-3">
            <p className="text-[10px] uppercase tracking-[0.2em] text-[#9ca3af]">Status</p>
            <p className="mt-1 text-xl font-semibold text-white">Alpha</p>
          </div>
          <div className="border border-[#374151] bg-[#111827] p-3">
            <p className="text-[10px] uppercase tracking-[0.2em] text-[#9ca3af]">Focus</p>
            <p className="mt-1 text-xl font-semibold text-white">Stablecoin</p>
          </div>
        </div>

        <section className="mt-9 border border-[#374151] bg-[#111827] p-4">
          <h2 className="text-2xl font-semibold text-white">Core Engine</h2>
          <ul className="mt-3 list-disc pl-5 text-[#cbd5e1]">
            <li>Burn-to-mint issuance model with deterministic collateral behavior.</li>
            <li>Multi-oracle aggregation and on-chain settlement logic.</li>
            <li>Composable swap primitives with fixed slippage curve design.</li>
          </ul>
        </section>

        <div className="mt-8 flex flex-wrap gap-2">
          <a href="/docs" className="rounded-sm border border-[#4b5563] bg-[#1f2937] px-3 py-2 text-xs font-semibold uppercase tracking-[0.15em] text-[#d1d5db] hover:border-[#60a5fa] hover:text-[#60a5fa]">Docs</a>
          <span className="rounded-sm border border-[#4b5563] px-3 py-2 text-xs font-semibold uppercase tracking-[0.15em] text-[#555]">Audit</span>
          <span className="rounded-sm border border-[#4b5563] px-3 py-2 text-xs font-semibold uppercase tracking-[0.15em] text-[#555]">Explorer</span>
        </div>
      </main>
    </div>
  );
}
