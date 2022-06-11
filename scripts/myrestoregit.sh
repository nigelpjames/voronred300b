#!/bin/bash

read -p "** WARNING *** This will reset the local GIT repository and overwrite any uncomitted changes - press [Enter] to continue or Ctrl-C to abort"

cd ~/klipper_config
git fetch
git reset --hard HEAD
git merge '@{u}'

read -p "** WARNING *** The moonraker database will now be restored - press [Enter] to continue or Ctrl-C to abort"
systemctl stop moonraker
ls -al .moonraker_database_backup/data.mdb
cp .moonraker_database_backup/data.mdb ~/.moonraker_database/
systemctl start moonraker
