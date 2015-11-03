#!/bin/bash
#Requirements: diffcolor

#This script concatenates multiple files of haproxy configuration into
#one file, and than checks if monolithic config contains errors. If everything is
#OK with new config script will write new config to $CURRENTCFG and reload haproxy
#Also, script will commit changes to etckeeper, if you don't use etckeeper you
#should start using it.
#Script assumes following directory structure:
#/etc/haproxy/conf.d/
#├── 00-global.cfg
#├── 15-lazic.cfg
#├── 16-togs.cfg
#├── 17-svartberg.cfg
#├── 18-home1.cfg.disabled
#└── 99-globalend.cfg
#Every site has it's own file, so you can disable site by changing
#it's file extension, or appending .disabled, like I do.


CONFIGDIR=/etc/haproxy/conf.d
RESULTCFG=/etc/haproxy/haproxy.cfg
TMPCFG=/tmp/haproxy.cfg.tmp

echo "Compiling *.cfg files from $CONFIGDIR"
ls -1 $CONFIGDIR/*.cfg
cat $CONFIGDIR/*.cfg > $TMPCFG

if [[ -s $RESULTCFG ]]; then
  echo "Differences between current and new config"
  diff -s -U 3 $RESULTCFG $TMPCFG | colordiff
  if [ $? -ne 0 ]; then
    echo "You should make some changes first :)"
    exit 0 #Exit if old and new configuration are the same
  fi
fi

echo -e "Checking if new config is valid..."
haproxy -c -f $TMPCFG

if [ $? -eq 0 ]; then
  mv $TMPCFG $RESULTCFG
else
  echo "There are errors in new configuration, please fix them and try again."
  exit 1
fi
