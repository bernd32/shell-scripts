#!/bin/bash

# CPU and GPU temperatures
echo "CPU Temperature:"
sensors | grep -E "Package|Core" | sed 's/^  *//'
echo ""
echo "GPU Temperature:"
nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits

# CPU, GPU, and RAM usage
echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'
echo ""
echo "GPU Usage:"
nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits
echo ""
echo "RAM Usage:"
free -h | grep Mem | awk '{print $3 "/" $2}'

# Network usage
echo ""
echo "Network Usage:"
rx_bytes_before=$(cat /proc/net/dev | grep $(ip route | grep default | awk '{print $5}') | awk '{print $2}')
tx_bytes_before=$(cat /proc/net/dev | grep $(ip route | grep default | awk '{print $5}') | awk '{print $10}')
sleep 1
rx_bytes_after=$(cat /proc/net/dev | grep $(ip route | grep default | awk '{print $5}') | awk '{print $2}')
tx_bytes_after=$(cat /proc/net/dev | grep $(ip route | grep default | awk '{print $5}') | awk '{print $10}')

rx_speed=$((($rx_bytes_after - $rx_bytes_before) / 1024))
tx_speed=$((($tx_bytes_after - $tx_bytes_before) / 1024))

echo "Download: $rx_speed kB/s | Upload: $tx_speed kB/s"

# Free disk space
echo ""
echo "Free Disk Space:"
df -h --output=source,target,avail | grep -v tmpfs | grep -v udev

# Uptime
echo ""
echo "Uptime:"
uptime -p

# Count and display number of available updates using checkupdates
num_updates=$(checkupdates | wc -l)
echo "Number of available updates: $num_updates"
