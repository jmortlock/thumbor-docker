#!/bin/sh

if [ ! -f /usr/local/etc/thumbor.conf ]; then
  envtpl /usr/local/etc/thumbor.conf.tpl  --allow-missing --keep-template
fi

# If log level is defined we configure it, else use default log_level = info
if [ -n "$LOG_LEVEL" ]; then
    LOG_PARAMETER="-l $LOG_LEVEL"
fi

# Check if thumbor port is defined -> (default port 8888)
if [ -z ${THUMBOR_PORT+x} ]; then
    THUMBOR_PORT=8888
fi

if [ "$1" = 'thumbor' ]; then
    exec python -m thumbor/server --port=$THUMBOR_PORT --conf=/usr/local/etc/thumbor.conf $LOG_PARAMETER
fi

exec "$@"
