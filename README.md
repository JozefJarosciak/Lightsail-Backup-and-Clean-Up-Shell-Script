# lightsail
Shell script to automatically remove old AWS Lightsail snapshots (and retain only a specific number of snapshot backups)

Assuming you only have a single instance running in your Lightsail account, you can schedule the following bash script as a cron job to do your old snapshot clean up automatically.

Note: Adjust variable snapshotsToKeep to whatever number of snapshots you’d like to keep.
