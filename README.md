
## Deploy Win server with terraform on AWS
To deploy windows AD in AWS execute 'terraform apply'
Once the script finishes, windows will restart. You will have to log in to finish installation, some scripts that where copied to windows with terraform will be executed as soon as you login the first time.
Windows will reboot again. At this point when AD comes back up it is ready for use.
Some scripts will also be executed like 'ansible script' to get windows ready for ansible management if you decide that you will use ansible to manage users, if not you can just remove script before deploying AD.
There is also a powershell script that will add bulk users to AD from CSV file if you need when you first deploy AD. Keep in mind that this file 'CSV file' will have sensitive info and treat it different.

References: https://docs.microsoft.com/en-us/powershell/module/addsadministration/new-aduser?view=win10-ps
            https://docs.ansible.com/ansible/latest/user_guide/windows.html