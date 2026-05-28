#!/bin/bash

git clone https://github.com/pik-piam/mrtutorial.git /workspaces/mrtutorial
mkdir /workspaces/madrat-main-folder

if [ -n "$GAMS_LICENSE" ]; then
  mkdir -p /opt/var/gams
  echo "$GAMS_LICENSE" > /opt/var/gams/gamslice.txt
fi

cd /workspaces/magpie
Rscript -e '2 + 2; "dummy evaluation to trigger renv install"'

cd /workspaces/mrtutorial
Rscript -e 'pak::pak(".")'
echo "" >> ~/.bashrc
echo "export MADRAT_MAINFOLDER='/workspaces/madrat-main-folder'" >> ~/.bashrc
echo "" >> ~/.bashrc

# Also set the mainfolder for the current session already,
# as the .bashrc is only loaded later.
MADRAT_MAINFOLDER='/workspaces/madrat-main-folder'
