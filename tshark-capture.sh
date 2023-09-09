#!/bin/bash

timeout 1m tshark >> /var/log/tshark.log
logrotate /etc/logrotate.d/tshark-capture
