#!/usr/bin/env bash

ignored_serial_test="[^\
podman unpause --all|\
podman run --volumes : basic|\
podman update - resources on update are not changed unless requested|\
podman update - test all options|\
rootless podman only ever uses single pause process|\
podman kube restore user namespace\
]"
ignored_parallel_test="[^\
events with disjunctive filters - journald|\
podman pod top - containers in different PID namespaces\
]"

export PODMAN=podman
bats -T --filter-tags '!ci:parallel' -f "$ignored_serial_test" test/system/
bats -T --filter-tags ci:parallel -f "$ignored_parallel_test" -j $(nproc) test/system/
