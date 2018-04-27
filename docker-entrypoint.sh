#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####
: ${SSH_PASS:=jenkins}

# add command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- supervisord "$@"
fi

#run command in background
if [ "$1" = 'supervisord' ]; then
  ##### run scripts  #####
  echo "========================================================================"
  echo "startup                                                                 "
  echo "========================================================================"
  exec "$@" &

  ##### post scripts  #####
  echo "========================================================================"
  echo "migration databases                                                     "
  echo "========================================================================"
  sentinel=/opt/jumpserver/data/inited
  if [ -f  ${sentinel} ];then
    echo "database have been inited"
  else
    cd /opt/jumpserver/utils
    ./make_migrations.sh && echo "database init success" && touch $sentinel
  fi

  #bring command to foreground
  fg
else
  exec "$@"
fi
