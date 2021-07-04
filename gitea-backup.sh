# Copyright 2021 the Bag of Scripts and Configurations authors. All rights reserved. NPLv5+ license.
#!/bin/bash

# https://www.davidpashley.com/articles/writing-robust-shell-scripts/
set -e

# https://stackoverflow.com/a/2173421
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

STAMP=$(date --iso-8601)
GITEA_DUMP1=gitea-workdir-$STAMP.tar.gz
GITEA_DUMP2=gitea-dump-$STAMP.zip
FOLDER=/tmp/gitea-backup

mkdir -p $FOLDER

# Do the standard backup
sudo -u git gitea dump -f $FOLDER/$GITEA_DUMP2 -c /etc/gitea/app.ini &

# Also save Gitea's data folder which is not included in the standard
# backup command.
sudo -u git tar -C / -czf $FOLDER/$GITEA_DUMP1 var/lib/gitea &

wait

sudo chown -v nilsnh:nilsnh -R $FOLDER

echo Done with work