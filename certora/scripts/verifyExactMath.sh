#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoHarness.sol \
    --verify MorphoHarness:certora/specs/ExactMath.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --prover_args '-smt_hashingScheme plaininjectivity -mediumTimeout 12' \
    --msg "Morpho Blue Exact Math" \
    "$@"
