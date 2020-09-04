BACKUP_DIRECTORY="/storage/minecraft-backup" # Where backups will go
SERVER_DIRECTORY="/storage/minecraft-live" # Live game world directory

DATE_FORMAT="%F_%H-%M-%S"
TIMESTAMP=$(date +$DATE_FORMAT)

ARCHIVE_FILE_NAME=HEMMESERVERBACKUP_$TIMESTAMP.tar.gz
ARCHIVE_PATH=$BACKUP_DIRECTORY/$ARCHIVE_FILE_NAME

docker exec mc rcon-cli say Starting backup...
docker exec mc rcon-cli save-off

tar -cvzf $ARCHIVE_PATH -C $SERVER_DIRECTORY . --exclude *.jar

docker exec mc rcon-cli save-on
docker exec mc rcon-cli say Backup complete!