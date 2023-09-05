#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoHarness.sol \
    --verify MorphoHarness:certora/specs/ExitLiquidity.spec \
    --solc_allow_path src \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --msg "Morpho Blue Exit Liquidity" \
    "$@"
