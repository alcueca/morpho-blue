#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoHarness.sol \
    --verify MorphoHarness:certora/specs/LibSummary.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --msg "Morpho Blue Lib Summary" \
    "$@"
