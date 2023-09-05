#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoHarness.sol \
    src/mocks/OracleMock.sol \
    --verify MorphoHarness:certora/specs/ExactMath.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --prover_args '-smt_hashingScheme plaininjectivity' \
    --msg "Morpho Blue Exact Math" \
    "$@"
