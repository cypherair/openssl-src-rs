# openssl-src-rs arm64e Status

Snapshot date: 2026-07-16

## Repo Identity

- Local path: `/Users/tianren/coding/openssl-src-rs`
- Git form: standalone repository with an OpenSSL submodule
- Local main branch: `main`
- Local carry branch: `carry/apple-arm64e-openssl-fork`
- Remote repository: `cypherair/openssl-src-rs`
- Upstream repository: `alexcrichton/openssl-src-rs`
- Relevant remote branches:
  - `origin/main`
  - `origin/carry/apple-arm64e-openssl-fork`
  - `upstream/main`

## Role In The arm64e Chain

This repo is the glue layer that lets the CypherAir Rust fork and app build
chain consume the CypherAir OpenSSL fork. It is the bridge between "patched
Rust toolchain" and "forked OpenSSL target definitions".

## Current Progress

- The active carry branch exists and is in use by the CypherAir app repository.
- The carry package version is `openssl-src` `300.6.1+3.6.3`, matching
  OpenSSL 3.6.3.
- The OpenSSL submodule is pinned to CypherAir carry merge
  `e9038561371fe42b0cba8002d46be05f4f87906f`. That merge retains the Apple
  arm64e Configure targets, imports the official OpenSSL 3.6.3 release, and
  signs the assembly-selected Poly1305 callbacks for the arm64e C function
  pointer ABI.
- tvOS wrapper builds disable the unused OpenSSL applications because libapps
  calls `fork()`, which the tvOS SDK prohibits. The carry workflow compiles a
  packaged aarch64 tvOS testcrate so this library-only policy cannot regress.
- The app currently patches `openssl-src` to this fork's
  `carry/apple-arm64e-openssl-fork` branch, with the app-side `Cargo.lock`
  recording the resolved commit. This repo is part of the active chain rather
  than a dormant fork. The app lockfile advances to this refreshed carry in a
  separate consumer PR after this carry update merges.
- The remaining work is upstreaming and chain cleanup, not basic enablement.
- The carry branch now has a focused GitHub Actions workflow,
  `.github/workflows/arm64e-carry-chain.yml`, that validates the OpenSSL
  submodule URL, expected branch, committed pointer freshness, Cargo package
  shape, and packaged testcrate path on macOS.

## Current Chain Relationship

- The app repository `pgp-mobile/Cargo.toml` patches `openssl-src` to this
  fork's `carry/apple-arm64e-openssl-fork` branch.
- This carry branch is expected to point at the CypherAir OpenSSL fork rather
  than upstream OpenSSL.
- `.gitmodules` records `carry/apple-arm64e-targets` as the OpenSSL submodule
  branch, and the committed submodule pointer should be kept at that carry
  branch's current validated head.
- Until the OpenSSL-side target-definition work lands upstream, this branch
  should be treated as downstream carry glue, not as a standalone upstream PR
  candidate.

## Related Forks And Paths

- App repository:
  - `/Users/tianren/coding/cypherair-main`
  - canonical branch: `main`
- Rust fork:
  - `/Users/tianren/coding/rust`
  - branch `carry/cypherair-arm64e-toolchain-stable-1.97`
- OpenSSL target-definition fork:
  - `/Users/tianren/coding/openssl`

## Upstreaming Posture

- Current posture: downstream carry glue
- Upstreaming expectation: this repo can only be simplified meaningfully after
  the OpenSSL-side target-definition work no longer depends on a CypherAir-only
  fork

## Update Rules

Update this file whenever any of the following changes:

- the `openssl-src` patch target, branch, or lockfile policy used by the app
  repository
- the OpenSSL submodule pointer or branch policy
- the carry-chain CI workflow or pointer-freshness rules
- the local/remote carry branch names
- the relationship between this repo and the OpenSSL fork
- the upstreaming posture of the carry branch
