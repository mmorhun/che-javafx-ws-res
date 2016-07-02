#! /bin/bash

# run supervisor which will run other programs
/usr/bin/supervisord -c /opt/supervisord.conf;

# execute command from CMD section
exec "$@"

