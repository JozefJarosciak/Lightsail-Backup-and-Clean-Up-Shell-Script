# Lightsail Backup and Clean Up Shell Script

Shell script to automatically backup a Lightsail snapshot and then remove old AWS Lightsail snapshots (by retaining only a specific number of snapshot backups).

Assuming you only have a single instance running in your Lightsail account, you can schedule the following bash script as a cron job to do your old snapshot clean up automatically. 

I've documented entire process on my blog:

- How to schedule nightly backups of Amazon Lightsail Instance by leveraging AWS Command Line Interface (CLI)
https://www.joe0.com/2017/07/29/how-to-schedule-nightly-backups-of-amazon-lightsail-instance-by-leveraging-aws-command-line-interface-cli/

- Shell script to automatically remove old AWS Lightsail snapshots (and retain a specific number of backups):
https://www.joe0.com/2017/07/31/shell-script-to-automatically-remove-old-aws-lightsail-snapshots-and-retain-only-a-specific-desired-number-of-snapshots/

Important:
If you have more than a single Lightsail instance running, then the first (snapshot creation) part of the script will still work just fine, but the second part (clean up of old snapshots) needs to be adjusted (you're welcome to contribute this part to the existing code).

Enjoy!
