#!/bin/bash

if [ -n "$GAMS_LICENSE" ]; then
  mkdir -p /opt/var/gams
  echo "$GAMS_LICENSE" > /opt/var/gams/gamslice.txt
fi
