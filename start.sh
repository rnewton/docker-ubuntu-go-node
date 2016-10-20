#!/usr/bin/env bash

# execute local startup script if one is available
if [ -f "/docker/start.sh" ]; then
    chmod +x /docker/start.sh
    /docker/start.sh
fi

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
