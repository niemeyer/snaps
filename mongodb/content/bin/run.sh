#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	SNAP_DATA=$SNAP_USER_DATA
fi

if [ -f $SNAP_DATA/environment ]; then
	. $SNAP_DATA/environment
fi

OPTIONS=
if [ -f $SNAP_DATA/${1}-options ]; then
	OPTIONS=$(cat $SNAP_DATA/${1}-options)
fi
if [ "$1" = mongod -o "$1" = mongo ]; then
	if [ -z "${@:2}" ]; then
		OPTIONS="--port=${SNAP_NAME:5}017 $OPTIONS"
	fi
fi
if [ "$1" = mongod ]; then
	if ! echo "$@" | grep -q -- --dbpath; then
		OPTIONS="--dbpath=$SNAP_DATA/../common $OPTIONS"
	fi
fi

export LC_ALL=C 
exec $SNAP/bin/$1 $OPTIONS "${@:2}"
