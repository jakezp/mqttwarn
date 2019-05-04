#!/bin/bash

# Set up default mqttwarn.ini
if [[ ! -f /opt/mqttwarn/conf/mqttwarn.ini ]]; then
  cp /opt/mqttwarn/mqttwarn.ini.sample /opt/mqttwarn/conf/mqttwarn.ini
fi

# Use supervisord to start all processes
echo -e "Starting supervisord"
supervisord -c /etc/supervisor/conf.d/supervisord.conf
