#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/TransferHarness.sol \
    certora/dispatch/ERC20Standard.sol \
    certora/dispatch/ERC20USDT.sol \
    certora/dispatch/ERC20NoRevert.sol \
    --verify TransferHarness:certora/specs/Transfer.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --msg "Morpho Blue Transfer" \
    "$@"
