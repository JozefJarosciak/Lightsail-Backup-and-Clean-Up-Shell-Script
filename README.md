# lightsail
Shell script to automatically remove old AWS Lightsail snapshots (and retain only a specific number of snapshot backups)

Assuming you only have a single instance running in your Lightsail account, you can schedule the following bash script as a cron job to do your old snapshot clean up automatically. If you have more then a single instance running, then the first (snapshot creation) part of the script will still work just fine, but the second part (clean up of old snapshots) needs to be adjusted (you're welcome to contribute this part to the existing code).

Note: Adjust variable snapshotsToKeep to whatever number of snapshots you’d like to keep.

I've documented entire process on my blog:

- How to schedule nightly backups of Amazon Lightsail Instance by leveraging AWS Command Line Interface (CLI)
https://www.joe0.com/2017/07/29/how-to-schedule-nightly-backups-of-amazon-lightsail-instance-by-leveraging-aws-command-line-interface-cli/

- Shell script to automatically remove old AWS Lightsail snapshots (and retain a specific number of backups):
https://www.joe0.com/2017/07/31/shell-script-to-automatically-remove-old-aws-lightsail-snapshots-and-retain-only-a-specific-desired-number-of-snapshots/

Enjoy!
