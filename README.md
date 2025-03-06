This script checks and displays the file descriptor limits for duroslight processes, showing:

Server hostname
LimitNOFILE value from the service configuration
Actual "Max open files" limit for the running process

Usage
sudo chmod +x FDlimit-check.sh
sudo ./FDlimit-check.sh

Example Output
CopyHostname: rack02-server58
LimitNOFILE: 100000
Max open files: 100000

Requirements
Bash shell environment
Root/sudo access (to read process limits)
