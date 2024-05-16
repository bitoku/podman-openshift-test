#!/usr/bin/env bash

umount $(mount | grep -o '/proc.*(ro' | awk '{ print $1 }')

exec "$@"
