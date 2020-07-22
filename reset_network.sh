#!/bin/bash

## Reset network prior to set up

nmcli con del $(nmcli -t -f UUID con show | while read p; do echo "$p"; done;)
nmcli con add type ethernet con-name em1 ifname em1
nmcli con up em1