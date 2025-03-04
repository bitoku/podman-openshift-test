#!/usr/bin/env bash

TEST_DIR=test/system
function insert_skip {
	file=$1
	testcase=$2
	# escape slash
	testcase=$(echo $testcase | sed 's/\//\\\//')
	echo $testcase
	sed -i "/$testcase/a\
	skip 'not working in cri-o'" "$TEST_DIR/$file"
}

# untriaged
# insert_skip 080-pause.bats "podman unpause --all"
# insert_skip 160-volumes.bats "podman run --volumes : basic"
# insert_skip 200-pod.bats "podman pod top - containers in different PID namespaces"
# insert_skip 280-update.bats "podman update - resources on update are not changed unless requested"
# insert_skip 280-update.bats "podman update - test all options"
# insert_skip 550-pause-process.bats "rootless podman only ever uses single pause process"

# userns
rm test/system/170-run-userns.bats
insert_skip 700-play.bats "podman kube restore user namespace" # usernamespace

# cat: /proc/sys/net/core/wmem_default: No such file or directory
# https://github.com/moby/moby/issues/30778
insert_skip 505-networking-pasta.bats "UDP/IPv4 large transfer, tap"
insert_skip 505-networking-pasta.bats "UDP/IPv4 large transfer, loopback"
insert_skip 505-networking-pasta.bats "UDP/IPv6 large transfer, tap"
insert_skip 505-networking-pasta.bats "UDP/IPv6 large transfer, loopback"

# cgroup
# cannot pause the container without a cgroup
# https://github.com/containers/podman/issues/12782
insert_skip 080-pause.bats "podman pause/unpause"
insert_skip 600-completion.bats "podman shell completion test" # cannot pause the container without a cgroup

# systemd
rm $TEST_DIR/250-systemd.bats
rm $TEST_DIR/251-system-service.bats
rm $TEST_DIR/252-quadlet.bats
rm $TEST_DIR/255-auto-update.bats
rm $TEST_DIR/270-socket-activation.bats
insert_skip 030-run.bats "podman run --log-driver" # FAIL: podman logs, with driver 'journald'
insert_skip 035-logs.bats "podman logs - tail test, journald"
insert_skip 035-logs.bats "podman logs - multi journald"
insert_skip 035-logs.bats "podman logs restarted journald"
insert_skip 035-logs.bats "podman logs - since journald"
insert_skip 035-logs.bats "podman logs - until journald"
insert_skip 035-logs.bats "podman logs - --follow journald"
insert_skip 035-logs.bats "podman logs - --since --follow journald"
insert_skip 035-logs.bats "podman logs - --until --follow journald"
insert_skip 080-pause.bats "podman pause/unpause with HealthCheck interval"
insert_skip 090-events.bats "events with disjunctive filters - journald"
insert_skip 090-events.bats "events - container inspect data - journald"
insert_skip 420-cgroups.bats "podman run, preserves initial --cgroup-manager"
insert_skip 220-healthcheck.bats "podman healthcheck --health-log-destination journal"

