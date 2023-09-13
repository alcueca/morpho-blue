#!/bin/bash

set -euxo pipefail

make -C certora munged

certoraRun \
    certora/harness/MorphoInternalAccess.sol \
    --verify MorphoInternalAccess:certora/specs/Liveness.spec \
    --solc_via_ir \
    --solc_optimize 4294967295 \
    --msg "Morpho Blue Liveness" \
    "$@"
