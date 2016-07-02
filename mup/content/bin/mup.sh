#!/bin/bash

if [ $(id -u) -ne 0 ]; then
	SNAP_DATA=$SNAP_USER_DATA
fi

if [ -f $SNAP_DATA/environment ]; then
	. $SNAP_DATA/environment
fi

OPTIONS=
if [ x"$@" = x -a -f $SNAP_DATA/options ]; then
	OPTIONS="$(cat $SNAP_DATA/options)"
fi
if [ "$SNAP_NAME" = "mup-accounts" ]; then
	OPTIONS="-no-plugins $OPTIONS"
fi
if [ "$SNAP_NAME" = "mup-plugins" ]; then
	OPTIONS="-no-accounts $OPTIONS"
fi

exec $SNAP/bin/mup $OPTIONS "$@"
