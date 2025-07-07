#!/bin/sh
echo "Backing up MySQL..."
mysqldump -h db -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" > /backup/backup.sql
echo "Backup finished"
