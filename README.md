# Monitoring Dashboard Script

## Description

The `monitor_dashboard.sh` script provides a comprehensive dashboard for monitoring system resources on a Linux-based server. It includes information about CPU usage, memory, disk usage, network statistics, process monitoring, and service status. The script is designed to be user-friendly, with colored output and formatted sections for better readability. 

## Features

- **Memory Usage**: Displays total, used, free, and swap memory.
- **Top Applications**: Shows the top 10 applications consuming the most CPU and memory.
- **Network Monitoring**: Provides the number of concurrent connections, packet drops, and network traffic.
- **Disk Usage**: Displays disk space usage by mounted partitions and highlights partitions using more than 80% of the space.
- **System Load**: Shows the current load average and a breakdown of CPU usage.
- **Process Monitoring**: Displays the number of active processes and the top 5 processes by CPU and memory usage.
- **Service Monitoring**: Monitors the status of essential services such as `sshd`, `nginx`, `apache2`, and `iptables`.
- **Custom Dashboard**: Allows users to view specific parts of the dashboard using command-line switches.

## Prerequisites

Ensure the following commands are installed and accessible on your system:
- `ss`
- `netstat`
- `mpstat`
- `awk`
- `ps`
- `free`
- `df`
- `bc`

## Usage

Make the script executable and run it with the desired options:

```bash
chmod +x monitor_dashboard.sh
./monitor_dashboard.sh [options]
