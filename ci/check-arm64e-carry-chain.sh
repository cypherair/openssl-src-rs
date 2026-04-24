#!/usr/bin/env bash

set -euo pipefail

EXPECTED_OPENSSL_REPO="https://github.com/cypherair/openssl.git"
EXPECTED_OPENSSL_BRANCH="carry/apple-arm64e-targets"

git_ls_remote_with_retry() {
    local repository="$1"
    local ref="$2"
    local attempt
    for attempt in 1 2 3; do
        if git -c http.version=HTTP/1.1 ls-remote "$repository" "$ref"; then
            return 0
        fi
        sleep $((attempt * 5))
    done
    return 1
}

actual_repo="$(git config -f .gitmodules --get submodule.openssl.url)"
actual_branch="$(git config -f .gitmodules --get submodule.openssl.branch)"

if [ "$actual_repo" != "$EXPECTED_OPENSSL_REPO" ]; then
    echo "error: openssl submodule URL is $actual_repo, expected $EXPECTED_OPENSSL_REPO" >&2
    exit 1
fi

if [ "$actual_branch" != "$EXPECTED_OPENSSL_BRANCH" ]; then
    echo "error: openssl submodule branch is $actual_branch, expected $EXPECTED_OPENSSL_BRANCH" >&2
    exit 1
fi

submodule_commit="$(git ls-tree HEAD openssl | awk '{print $3}')"
if [ -z "$submodule_commit" ]; then
    echo "error: unable to resolve openssl submodule pointer" >&2
    exit 1
fi

remote_head="$(git_ls_remote_with_retry "$EXPECTED_OPENSSL_REPO" "refs/heads/$EXPECTED_OPENSSL_BRANCH" | awk '{print $1}')"
if [ -z "$remote_head" ]; then
    echo "error: unable to resolve $EXPECTED_OPENSSL_REPO $EXPECTED_OPENSSL_BRANCH" >&2
    exit 1
fi

if [ "$submodule_commit" != "$remote_head" ]; then
    echo "error: openssl submodule commit $submodule_commit is not current $EXPECTED_OPENSSL_BRANCH head $remote_head" >&2
    exit 1
fi

echo "openssl submodule URL: $actual_repo"
echo "openssl submodule branch: $actual_branch"
echo "openssl submodule commit: $submodule_commit"
echo "openssl branch head: $remote_head"
