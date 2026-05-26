#!/bin/bash

git clone https://github.com/pik-piam/mrtutorial.git /workspaces/mrtutorial
mkdir /workspaces/madrat-main-folder

if [ -n "$GAMS_LICENSE" ]; then
  mkdir -p /opt/var/gams
  echo "$GAMS_LICENSE" > /opt/var/gams/gamslice.txt
fi

cd /workspaces/magpie
Rscript -e '2 + 2; "dummy evaluation to trigger renv install"'