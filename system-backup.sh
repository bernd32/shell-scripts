#!/bin/bash

backup_files="/home /etc /root /boot /opt /usr/local"
# Ignore files that match the patterns listed in file
exclude_list="/home/bernd/Documents/backup_exclude.txt"
dest="/home/bernd/Documents/backups/"
day=$(date +%Y.%m.%d-%H-%M-%S)
archive_file="system-backup-$day.tar.gz"

echo "Backing up $backup_files to $dest/$archive_file"
date
echo

tar --exclude-from=$exclude_list -cvpzf $dest/$archive_file $backup_files

echo
echo "Finished"
echo "Excluded files:"
cat $exclude_list
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest
