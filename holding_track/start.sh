#!/bin/bash

/usr/sbin/lighttpd -f /lighttpd.conf
/usr/local/bin/flask run --host=0.0.0.0