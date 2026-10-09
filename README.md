# SplitCircle

A private expense-sharing web app with a premium responsive interface, built for groups, trips, and everyday shared expenses. Independent project; not affiliated with Splitwise.

## Features

- Shared group workspaces with expiring, revocable participant invitations
- Expense comments and immutable edit/deletion history
- Groups, friends, expense editing, and recorded settlements
- Equal, exact, percentage, share-based, and itemized splits
- Saved group split ratios and debt simplification
- Browser-based receipt OCR, side-by-side image review, item corrections and participant assignment
- Private image storage with shared-group receipt access
- Multiple currencies with stored conversion rates
- Spending breakdowns, monthly trends, and budgets
- Month comparisons, median-based spending spikes and paid-versus-shared charts
- System/light/dark themes, reduced motion, keyboard focus and larger text
- Recurring bills with manual review and posting
- CSV import/export, JSON backup, and a separate demo workspace
- Mobile navigation and accessible expense dialogs

## Stack

React 19, TypeScript, Vinext/Vite, Tailwind CSS, Radix UI, Cloudflare Workers, D1, R2, Drizzle, and Tesseract.js.

## Development

Requires Node.js 22.13 or newer and pnpm matching the `packageManager` field in `package.json`.

```sh
pnpm install --frozen-lockfile
pnpm exec tsc --noEmit
pnpm run build
```

Before using the local ledger, initialize the local database once:

```sh
node --import ./scripts/sites-env.mjs ./node_modules/wrangler/bin/wrangler.js d1 execute DB --local --config dist/server/wrangler.json --persist-to .wrangler/state --file drizzle/0000_material_black_panther.sql
node --import ./scripts/sites-env.mjs ./node_modules/wrangler/bin/wrangler.js d1 execute DB --local --config dist/server/wrangler.json --persist-to .wrangler/state --file drizzle/0001_lumpy_tomas.sql
pnpm run dev
```

Open the local URL printed by the development server. In portable development, visit `/signin-with-chatgpt?return_to=/` to use the starter's loopback-only test identity. Production uses platform-provided authentication. Never expose local mock authentication to the internet.

See [runtime documentation](docs/runtime.md) for execution profiles and the original starter integration details. This repository uses pnpm; use its commands instead of npm installation examples in the starter documentation.

## Hosting

The app currently runs on ChatGPT Sites. `.openai/hosting.json` identifies that existing Site and declares the `DB` and `BUCKET` bindings. Pushing source to GitHub does not publish a new Site version or copy production data.

**GitHub Pages alone cannot run this app.** Its server routes require a Worker runtime, database, object storage, and authenticated user identity. Deploying independently requires configuring those resources and replacing or implementing the trusted authentication boundary; simply accepting identity headers from public clients is unsafe.

## Data and privacy

Expense data lives in D1; receipt images live in R2. Runtime databases, receipts, credentials, build output, and dependency directories are excluded from Git. The source includes a clearly labelled sample ledger. Account identity is read from authenticated user context.

Never commit API keys, access tokens, `.env` files, or live expense exports. GitHub contains source only, not a backup of your financial records.

## Current scope

- Groups can be copied into shared workspaces. The personal copy remains a snapshot; shared edits happen in the shared workspace. Group-specific settlements are copied; cross-group settlements are excluded.
- Invitation links expire after seven days and can be revoked before use. A link holder claims the named participant; share it only with that friend.
- The deployed Site currently remains owner-only. Friends must be granted Site access before accepting invitations; application APIs then enforce group membership. Changing site audience is a separate owner action.
- Shared changes use revision checks to prevent overwrites. Use Refresh workspace to load another member’s changes.
- Edit history starts with this update; it cannot reconstruct earlier edits.
- Payments are recorded, not transferred.
- Recurring bills are manually reviewed and posted, not automatically charged.
- Direct bank linking is not connected; CSV import is available.
- OCR requires review and may need manual correction.
- Reference exchange rates depend on provider availability; a manual rate can be entered.

## Verification

The latest app passed TypeScript and production build checks. Ledger checks covered rounding, balance conservation, settlements, currency conversion, and recurring dates. Additional checks cover participant-perspective round trips, per-group data isolation, history generation, migration preservation and membership uniqueness. Visual and two-account end-to-end browser testing have not yet been performed.

## Licensing

No project-wide open-source licence has been selected. Bundled third-party files retain their existing licence notices. Choose a licence before inviting public reuse.
