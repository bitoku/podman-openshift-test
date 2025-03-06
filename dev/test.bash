#!/usr/bin/env bash
set -e

TEST_DIR=test/system
function insert_skip {
	file=$1
	testcase=$2
	# escape slash
	testcase=$(echo $testcase | sed 's/\//\\\//g')
	echo $testcase
	sed -i "/$testcase/a\
	skip 'not working in cri-o'" "$TEST_DIR/$file"
}

# # /home/podman/go/src/github.com/containers/podman/test/system/helpers.bash: line 1117: /usr/bin/expr: Argument list too long
# insert_skip 200-pod.bats "podman pod top - containers in different PID namespaces"
# 
# # can't finish
# insert_skip 700-play.bats "podman kube play --wait with siginterrupt"
# 
# # FAIL: Pause process 42825 is still running even after podman system migrate
# insert_skip 550-pause-process.bats "rootless podman only ever uses single pause process"
# 
# # mount not shown
# insert_skip 160-volumes.bats "podman run --volumes : basic"
# 
# # ping: permission denied (are you root?) 
# insert_skip 200-pod.bats "podman pod create - hashtag AllTheOptions"
# 
# # systemd can't run in nested container
# insert_skip 030-run.bats "podman run - /run must not be world-writable in systemd containers"
# 
# # There is only one tty - /dev/tty
# insert_skip 030-run.bats 'podman run --privileged as rootless will not mount /dev/tty\\d+'
# 
# # Can't handle signal properly
# insert_skip 030-run.bats "podman run - stopping loop"
# insert_skip 065-cp.bats "podman cp file from/to host while --pid=host"
# insert_skip 220-healthcheck.bats "podman healthcheck --health-on-failure with interval"
# insert_skip 195-run-namespaces.bats "podman test all namespaces"
# 
# # healthcheck (systemd or signal)
# insert_skip 055-rm.bats "podman container rm doesn't affect stopping containers"
# insert_skip 055-rm.bats "podman container rm --force doesn't leave running processes"
# insert_skip 220-healthcheck.bats "podman healthcheck"
# insert_skip 220-healthcheck.bats "podman healthcheck - stop container when healthcheck runs"
# insert_skip 700-play.bats "podman kube play healthcheck should wait initialDelaySeconds before updating status"
# 
# # userns
# insert_skip 170-run-userns.bats "podman userns=auto in config file"
# insert_skip 170-run-userns.bats "podman userns=auto and secrets"
# insert_skip 170-run-userns.bats "podman userns=auto with id mapping"
# insert_skip 700-play.bats "podman kube restore user namespace" # usernamespace

# # cat: /proc/sys/net/core/wmem_default: No such file or directory
# # https://github.com/moby/moby/issues/30778
# insert_skip 505-networking-pasta.bats "UDP/IPv4 large transfer, tap"
# insert_skip 505-networking-pasta.bats "UDP/IPv4 large transfer, loopback"
# insert_skip 505-networking-pasta.bats "UDP/IPv6 large transfer, tap"
# insert_skip 505-networking-pasta.bats "UDP/IPv6 large transfer, loopback"
# 
# # cgroup
# # cannot pause the container without a cgroup
# # https://github.com/containers/podman/issues/12782
# insert_skip 080-pause.bats "podman pause/unpause"
# insert_skip 600-completion.bats "podman shell completion test" # cannot pause the container without a cgroup
# # opening file `memory.max` for writing: Permission denied
# insert_skip 280-update.bats "podman update - test all options"
# insert_skip 280-update.bats "podman update - resources on update are not changed unless requested"
# # FAIL: the cgroup /sys/fs/cgroup//libpod_parent/25782bbdb63829f5fed5693db2f11777d1d8ea599bc0311500b5f4f01cca2f11 does not exist
# insert_skip 200-pod.bats "podman pod cleans cgroup and keeps limits"

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
insert_skip 035-logs.bats "podman logs - journald log driver requires journald events backend"
insert_skip 080-pause.bats "podman pause/unpause with HealthCheck interval"
insert_skip 090-events.bats "events with disjunctive filters - journald"
insert_skip 090-events.bats "events - container inspect data - journald"
insert_skip 090-events.bats "events with file backend and journald logdriver with --follow failure"
insert_skip 220-healthcheck.bats "podman healthcheck --health-log-destination journal"
insert_skip 420-cgroups.bats "podman run, preserves initial --cgroup-manager"
insert_skip 505-networking-pasta.bats "pasta(1) quits when the namespace is gone" # zombie process is not handled
