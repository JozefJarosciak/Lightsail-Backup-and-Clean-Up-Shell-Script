# Lightsail Backup and Clean Up Shell Script

## Dependencies
jq: https://stedolan.github.io/jq/download/

## Instructions
Shell script to automatically backup a Lightsail snapshot and then remove old AWS Lightsail snapshots (by retaining only a specific number of snapshot backups).

This script will take in three arguments. 
1. The instance you want to backup
2. The AWS region where the lightsail instrance is located.
3. The number of backups that you would like to keep.

To execute the script:

'$ bash lightsail-backup.sh [instance] [region] [backups kept] '

## Scheduling Backups

Follow the instructions referenced in the below blog which includes how to configure the AWS CLI and schedule the jobs in crontab:
https://www.joe0.com/2017/07/29/how-to-schedule-nightly-backups-of-amazon-lightsail-instance-by-leveraging-aws-command-line-interface-cli/

## Special Thanks

- Shell script to automatically remove old AWS Lightsail snapshots (and retain a specific number of backups that inspired my fork:
https://www.joe0.com/2017/07/31/shell-script-to-automatically-remove-old-aws-lightsail-snapshots-and-retain-only-a-specific-desired-number-of-snapshots/
