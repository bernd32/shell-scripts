# shell-scripts
A bunch of useful shell scripts 
### system-backup.sh
A simple shell script that backs up your system using the `tar` utility. To use it, create a backup_exclude.txt file that lists the files and directories to be ignored during the backup. Also, remember to specify the location of the backup_exclude.txt file in the `exclude_list` variable.

### sysmon.sh
A system monitoring script that prints:
- current CPU and GPU temperatures
- current GPU, CPU and RAM usage
- current network usage
- free disk space
- uptime

Works only with Nvidia GPUs.
Note that it requires the `lm-sensors` package for CPU temperature and `nvidia-smi` for GPU information. For `nvidia-smi`, you need to have the NVIDIA drivers installed.
