#!/bin/sh

# This script should be placed in /var/backups/crontabs
# It is run by a general backup script for the whole server
# It will back up every user's crontab

for user in $(cut -f1 -d: /etc/passwd)
do
	crontab=`crontab -u $user -l 2>&1`
	if [ "$crontab" != "no crontab for $user" ] && [ "$crontab" != "must be privileged to use -u" ] ; then
    		echo "writing $user.crontab backup file"
		echo "$crontab" > /var/backups/crontabs/$user.crontab
	fi
done
