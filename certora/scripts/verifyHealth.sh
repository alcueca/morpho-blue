#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoHarness.sol \
    certora/munged/mocks/OracleMock.sol \
    --verify MorphoHarness:certora/specs/Health.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --prover_args '-smt_hashingScheme plaininjectivity' \
    --msg "Morpho Blue Health Check" \
    "$@"
