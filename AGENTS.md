# CypherAir openssl-src-rs arm64e Carry Guide

This checkout is the CypherAir fork of `openssl-src-rs`, used as a downstream
carry layer for Apple `arm64e`.

## Repo Identity

- Local path: `/Users/tianren/coding/openssl-src-rs`
- Remote repository: `cypherair/openssl-src-rs`
- Upstream repository: `alexcrichton/openssl-src-rs`
- Local main branch: `main`
- Local carry branch: `carry/apple-arm64e-openssl-fork`

## Related Forks

- App experiment worktree:
  - `/Users/tianren/coding/cypherair-apple-arm64e-unified-experiment`
- Rust fork:
  - `/Users/tianren/coding/rust`
  - branch `codex/arm64e-upstream-ready-integration-2026-04-24-u9836b06`
- OpenSSL target-definition fork:
  - `/Users/tianren/coding/openssl`
  - branches `carry/apple-arm64e-targets`, `prep/apple-arm64e-targets`
- Related but currently unconfirmed in the active chain:
  - `/Users/tianren/coding/rust-openssl`

## Current Role

This repo is the glue layer between the Rust-side fork and the OpenSSL-side
fork. It exists so the CypherAir experiment can keep a reproducible OpenSSL
source build while still using Apple `arm64e` target mappings that do not yet
exist upstream.

Current downstream responsibilities include:

- Apple `arm64e` target-to-Configure mappings
- Apple SDK-specific `xcrun` / `CC` overrides
- the OpenSSL submodule pointer used by the current carry chain
- the `arm64e-carry-chain` workflow that checks the OpenSSL submodule URL,
  branch, and pointer before packaging and testcrate validation

Detailed arm64e progress belongs in [ARM64E_STATUS.md](ARM64E_STATUS.md). Keep
that file synchronized when branch topology, the OpenSSL fork pointer, or the
app-side dependency chain changes.

## Working Rules

- Keep the OpenSSL submodule pointing at the CypherAir OpenSSL fork, not
  upstream OpenSSL, unless the chain has intentionally changed.
- Keep `ci/check-arm64e-carry-chain.sh` and `.github/workflows/arm64e-carry-chain.yml`
  synchronized with the intended OpenSSL carry branch.
- If a change is only meaningful because the forked OpenSSL repo carries
  downstream config targets, document that clearly in code comments.
- Prefer the smallest mapping / SDK override change that preserves existing
  upstream behavior for non-experimental targets.
- Do not describe this branch as independently upstreamable while it still
  depends on the downstream OpenSSL fork.
