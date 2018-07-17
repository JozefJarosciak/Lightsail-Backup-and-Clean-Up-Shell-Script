#!/bin/bash

######################################
##   CREATE A NEW SNAPSHOT BACKUP   ##
######################################
## This script takes in three arguments the name of your instance, the region, and the number of snapshots to keep.

NameOfYourInstance=$1
NameOfYourBackup=$NameOfYourInstance
Region=$2

aws lightsail create-instance-snapshot --instance-snapshot-name ${NameOfYourBackup}-$(date +%Y-%m-%d_%H.%M) --instance-name $NameOfYourInstance --region $Region

## Delay before initiating clean up of old snapshots
sleep 30

###############################################
##   DELETE OLD SNAPSHOTS + RETAIN SNAPSHOTS ##
###############################################
# Set number of snapshots you'd like to keep in your account
snapshotsToKeep=$3
echo "Number of Instance Snapshots to keep: ${snapshotsToKeep}"

# get the total number of available Lightsail snapshots
numberOfSnapshots=$(aws lightsail get-instance-snapshots | jq '[.[]  | select(.[].fromInstanceName == "'${NameOfYourInstance}'") ]| length')
echo "Number of instance snapshots: ${numberOfSnapshots}"

# get the names of all snapshots sorted from old to new
SnapshotNames=$(aws lightsail get-instance-snapshots | jq '.[] | sort_by(.createdAt) | map(select(.fromInstanceName == "'${NameOfYourInstance}'")) | .[].name')

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
	fi

done <<< "$SnapshotNames"

exit 1
