#!/bin/bash

######################################
##   CREATE A NEW SNAPSHOT BACKUP   ##
######################################
## Adjust 'NameOfYourBackup' to whatever your backup name you'd like to be
## Adjust 'NameOfYourInstance' to actual name of the Lightsail Instance (you can find the name of your instance in the Lightsail console)
aws lightsail create-instance-snapshot --instance-snapshot-name NameOfYourBackup-$(date +%Y-%m-%d_%H.%M) --instance-name NameOfYourInstance --region us-east-2

## Delay before initiating clean up of old snapshots
sleep 30


##############################
##   DELETE OLD SNAPSHOTS   ##
##############################
# Set number of snapshots you'd like to keep in your account
snapshotsToKeep=4

# get the total number of available Lightsail snapshots
numberOfSnapshots=$(aws lightsail get-instance-snapshots | jq '.[]|length')

# get the names of all snapshots sorted from old to new
SnapshotNames=$(aws lightsail get-instance-snapshots | jq '.[] | sort_by(.createdAt) | .[].name')

# loop through all snapshots
while IFS= read -r line 
do 
let "i++"

# delete old snapshots condition
if (($i <= $numberOfSnapshots-$snapshotsToKeep))
then
snapshotToDelete=$(echo "$line" | tr -d '"')

# delete snapshot command
aws lightsail delete-instance-snapshot --instance-snapshot-name $snapshotToDelete 
echo "Deleted Snapshot: " + $line

fi

done <<< "$SnapshotNames"

exit 1
