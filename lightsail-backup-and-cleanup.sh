#!/bin/bash

######################################
##   CREATE A NEW SNAPSHOT BACKUP   ##
######################################
## Adjust 'NameOfYourBackup' to whatever your backup name you'd like to be
## Adjust 'NameOfYourInstance' to actual name of the Lightsail Instance (you can find the name of your instance in the Lightsail console)
## Adjust 'Region' to the region where your Lightsail instance is located.

NameOfYourInstance="BWTC_Web"
NameOfYourBackup=$NameOfYourInstance
Region="us-east-2"

aws lightsail create-instance-snapshot --instance-snapshot-name ${NameOfYourBackup}-$(date +%Y-%m-%d_%H.%M) --instance-name $NameOfYourInstance --region $Region

## Delay before initiating clean up of old snapshots
sleep 30

##############################
##   DELETE OLD SNAPSHOTS   ##
##############################
# Set number of snapshots you'd like to keep in your account
snapshotsToKeep=30
echo "Number of Instance Snapshots to keep: ${snapshotsToKeep}"

# get the total number of available Lightsail snapshots
numberOfSnapshots=$(aws lightsail get-instance-snapshots | jq '[.[]  | select(.[].fromInstanceName == "'${NameOfYourInstance}'") ]| length')
echo "Number of instance snapshots: ${numberOfSnapshots}"

# get the names of all snapshots sorted from old to new
SnapshotNames=$(aws lightsail get-instance-snapshots | jq '.[] | sort_by(.createdAt) | select(.[0].fromInstanceName == "'${NameOfYourInstance}'") | .[].name')

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
