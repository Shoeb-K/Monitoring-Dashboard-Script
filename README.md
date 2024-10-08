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
```

### Options

- `-a` : Show the full dashboard
- `-m` : Show memory usage
- `-c` : Show top 10 applications by CPU and memory usage
- `-n` : Show network statistics
- `-d` : Show disk usage
- `-s` : Show service status
- `-p` : Show process monitoring
- `-l` : Show system load
- `-h` : Display this help message

## Examples

- **Show the full dashboard**:

    ```bash
    ./monitor_dashboard.sh -a
    ```

- **Show only memory usage**:

    ```bash
    ./monitor_dashboard.sh -m
    ```

- **Show top applications by CPU and memory**:

    ```bash
    ./monitor_dashboard.sh -c
    ```

- **Show network statistics**:

    ```bash
    ./monitor_dashboard.sh -n
    ```

- **Show disk usage**:

    ```bash
    ./monitor_dashboard.sh -d
    ```

- **Check the status of essential services**:

    ```bash
    ./monitor_dashboard.sh -s
    ```

- **Show process monitoring**:

    ```bash
    ./monitor_dashboard.sh -p
    ```

- **Show system load**:

    ```bash
    ./monitor_dashboard.sh -l
    ```

- **Display help message**:

    ```bash
    ./monitor_dashboard.sh -h
    ```

## Customizing the Script

You can modify the list of services to monitor by editing the `SERVICES` array in the script:

```bash
SERVICES=("sshd" "nginx" "apache2" "iptables")
```

Add or remove services as needed to suit your environment.

## Notes

- The script uses ANSI escape codes for colored output, which may not display correctly in all terminal environments.
- Ensure you have sufficient permissions to run commands like `netstat` and `systemctl` if you're monitoring services.
- This script is designed for Linux-based systems and may require adjustments for other Unix-like environments.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

Enjoy monitoring your system with the Monitoring Dashboard Script!

## Key Sections:

1. **Description**: Overview of what the script does and its purpose.
2. **Features**: List of the script’s functionalities.
3. **Prerequisites**: Commands and tools needed for the script to run.
4. **Usage**: Instructions on how to execute the script and available options.
5. **Examples**: Practical examples of how to use different options.
6. **Customizing the Script**: Instructions for modifying the script to suit specific needs.
7. **Notes**: Additional information and potential issues to be aware of.
8. **Contributing**: Information on how to contribute to the project.
9. **License**: Licensing details for the project.

This README should help users understand how to use the script, customize it, and troubleshoot any issues they encounter.
