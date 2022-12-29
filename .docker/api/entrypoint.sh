#!/usr/bin/env bash

handler() {
    kill ${cmd_pid}
}

trap handler SIGTERM

rm -f ${WORKDIR}/tmp/pids/server.pid
"$@" &
cmd_pid=$!

wait $cmd_pid
exit $?
