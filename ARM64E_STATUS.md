# openssl-src-rs arm64e Status

Snapshot date: 2026-04-24

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

This repo is the glue layer that lets the CypherAir Rust and app experiments
consume the CypherAir OpenSSL fork. It is the bridge between "patched Rust and
app build flow" and "forked OpenSSL target definitions".

## Current Progress

- The active carry branch exists and is in use by the CypherAir experiment
  worktree.
- The app experiment currently patches `openssl-src` to this fork's
  `carry/apple-arm64e-openssl-fork` branch, with the app-side `Cargo.lock`
  recording the resolved commit. This repo is part of the active chain rather
  than a dormant fork.
- The remaining work is upstreaming and chain cleanup, not basic enablement.

## Current Chain Relationship

- App experiment worktree `pgp-mobile/Cargo.toml` patches `openssl-src` to this
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

- App experiment worktree:
  - `/Users/tianren/coding/cypherair-apple-arm64e-unified-experiment`
- Rust fork:
  - `/Users/tianren/coding/rust`
- OpenSSL target-definition fork:
  - `/Users/tianren/coding/openssl`
- Related but currently unconfirmed in the active chain:
  - `/Users/tianren/coding/rust-openssl`

## Upstreaming Posture

- Current posture: downstream carry glue
- Upstreaming expectation: this repo can only be simplified meaningfully after
  the OpenSSL-side target-definition work no longer depends on a CypherAir-only
  fork

## Update Rules

Update this file whenever any of the following changes:

- the `openssl-src` patch target, branch, or lockfile policy used by the app
  experiment
- the OpenSSL submodule pointer or branch policy
- the local/remote carry branch names
- the relationship between this repo and the OpenSSL fork
- the upstreaming posture of the carry branch
