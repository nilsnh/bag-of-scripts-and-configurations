# Copyright 2021 the Bag of Scripts and Configurations authors. All rights reserved. NPLv5+ license.
# !/bin/bash

# Utility script for packing up my workspace folders, without
# including dependencies such as node_modules and vendor
# Sources:
# https://superuser.com/a/665181

if [[ $# -eq 0 ]] ; then
    echo 'Please provide a workspace folder you want to zip up.'
    exit 0
fi

echo "packup starting up, targeting: $@"

tar \
	--exclude=node_modules \
	--exclude=vendor \
	-c $@ -P | \
	pv -s $(du -csb $@ | grep total | awk '{print $1}') \
	> packup-archive-$(date --iso-8601).tar
