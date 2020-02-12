#!/bin/bash

# Author: Jaidee King
set +e
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~ ATTEMpTING TO MIGRATE THE DB ~~~~~~~~~~~~~~~~~~~~~~~~"
bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
  echo "~~~~~~~~~~~~~~~~~~~~~MIGRATION FAILED; CREATING THE DATABASE~~~~~~~~~~~~~~~~~~"
  bin/rails db:create
  echo "~~~~~~~~~~~~~~~~~~~~~MIGRATING THE DATABASE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  bin/rails db:migrate
  bin/rails db:test:prepare
  echo "~~~~~~~~~~~~~~~~~~~~~~SEEDING THE DATABASE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  bin/rails db:seed
fi
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~REMOVING THE OLD SERVER PID~~~~~~~~~~~~~~~~~~~~"
rm -f tmp/pids/server.pid
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~STARTING THE WEBSERVER~~~~~~~~~~~~~~~~~~~~~"
bin/rails server -p 3000 -b '0.0.0.0'
