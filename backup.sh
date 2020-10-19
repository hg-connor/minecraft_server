BACKUP_DIRECTORY="/storage/minecraft-backup" # Where backups will go
SERVER_DIRECTORY="/storage/minecraft-live" # Live game world directory

DATE_FORMAT="%F_%H-%M-%S"
TIMESTAMP=$(date +$DATE_FORMAT)

ARCHIVE_FILE_NAME=HEMMESERVERBACKUP_$TIMESTAMP.tar.gz
ARCHIVE_PATH=$BACKUP_DIRECTORY/$ARCHIVE_FILE_NAME

# Disable mc server saving while we backup
docker exec mc rcon-cli say Starting backup...
docker exec mc rcon-cli save-off

# Create the backup file
tar -cvzf $ARCHIVE_PATH -C $SERVER_DIRECTORY . --exclude *.jar

# Delete any backups older than 10 days to save space, we run volume snapshots daily so this should just keep the size down
find $BACKUP_DIRECTORY* -mtime +10 -exec rm {} \;

# Re-enable the save functionality for the MC server once the backup is complete
docker exec mc rcon-cli save-on
docker exec mc rcon-cli say Backup complete!
