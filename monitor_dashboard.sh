#!/bin/bash

# Color variables for formatting
RESET="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
BOLD="\033[1m"

# Function to display memory usage
function show_memory_usage() {
    echo -e "${BOLD}${BLUE}==== Memory Usage ====${RESET}"
    free -h
    echo -e "\n${BOLD}${BLUE}==== Swap Usage ====${RESET}"
    free -h | awk '/Swap/ {print $0}'
    echo ""
}

# Function to display CPU and memory usage of top 10 applications
function show_top_apps() {
    echo -e "${BOLD}${BLUE}==== Top 10 Applications by CPU and Memory Usage ====${RESET}"
    echo -e "\n${BOLD}Top 10 by Memory:${RESET}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11 | awk '{printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, $3, $4, $5}'
    echo -e "\n${BOLD}Top 10 by CPU:${RESET}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 11 | awk '{printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, $3, $4, $5}'
    echo ""
}

# Function to display network statistics
function show_network_stats() {
    echo -e "${BOLD}${BLUE}==== Network Monitoring ====${RESET}"
    echo -e "\n${BOLD}Concurrent Connections:${RESET}"
    ss -tun | wc -l
    
    echo -e "\n${BOLD}Packet Drops:${RESET}"
    netstat -s | grep "packet receive errors"
    
    echo -e "\n${BOLD}Network Traffic (in MB):${RESET}"
    IFACE=$(ip -o -4 route show to default | awk '{print $5}')
    RX_BYTES=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
    TX_BYTES=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
    RX_MB=$(echo "scale=2; $RX_BYTES/1024/1024" | bc)
    TX_MB=$(echo "scale=2; $TX_BYTES/1024/1024" | bc)
    echo -e "Received: ${GREEN}$RX_MB MB${RESET}, Transmitted: ${GREEN}$TX_MB MB${RESET}"
    echo ""
}

# Function to display disk usage
function show_disk_usage() {
    echo -e "${BOLD}${BLUE}==== Disk Usage ====${RESET}"
    df -h | awk 'NR==1; NR > 1 {print $0 | "sort -k5 -nr"}' | awk -v RED=$RED -v RESET=$RESET '{ if($5+0 >= 80) printf RED"%s"RESET"\n", $0; else print $0; }'
    echo ""
}

# Function to display system load
function show_system_load() {
    echo -e "${BOLD}${BLUE}==== System Load ====${RESET}"
    echo -e "\n${BOLD}Load Average:${RESET}"
    uptime | awk -F'load average:' '{ print $2 }'
    
    echo -e "\n${BOLD}CPU Usage Breakdown:${RESET}"
    mpstat | awk '$12 ~ /[0-9.]+/ { printf "User: %s%%  Sys: %s%%  Idle: %s%%\n", $3, $5, $12 }'
    echo ""
}

# Function to display process monitoring
function show_process_stats() {
    echo -e "${BOLD}${BLUE}==== Process Monitoring ====${RESET}"
    echo -e "\n${BOLD}Number of Active Processes:${RESET}"
    ps aux | wc -l
    
    echo -e "\n${BOLD}Top 5 Processes by CPU:${RESET}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | awk '{printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, $3, $4, $5}'
    
    echo -e "\n${BOLD}Top 5 Processes by Memory:${RESET}"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | awk '{printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, $3, $4, $5}'
    echo ""
}

# Function to monitor essential services
function show_service_status() {
    echo -e "${BOLD}${BLUE}==== Service Monitoring ====${RESET}"
    SERVICES=("sshd" "nginx" "apache2" "iptables")
    
    for service in "${SERVICES[@]}"
    do
        if systemctl is-active --quiet $service; then
            echo -e "${GREEN}$service is running.${RESET}"
        else
            echo -e "${RED}$service is not running.${RESET}"
        fi
    done
    echo ""
}

# Function to display the full dashboard
function show_full_dashboard() {
    clear
    show_top_apps
    show_network_stats
    show_disk_usage
    show_system_load
    show_memory_usage
    show_process_stats
    show_service_status
}

# Parse command-line arguments for custom dashboard
while getopts "amcndsplh" opt; do
  case $opt in
    a)
      show_full_dashboard
      ;;
    m)
      show_memory_usage
      ;;
    c)
      show_top_apps
      ;;
    n)
      show_network_stats
      ;;
    d)
      show_disk_usage
      ;;
    s)
      show_service_status
      ;;
    p)
      show_process_stats
      ;;
    l)
      show_system_load
      ;;
    h)
      echo -e "${BOLD}Usage: $0 [options]${RESET}"
      echo "Options:"
      echo "  -a    Show full dashboard"
      echo "  -m    Show memory usage"
      echo "  -c    Show top 10 applications by CPU and memory usage"
      echo "  -n    Show network statistics"
      echo "  -d    Show disk usage"
      echo "  -s    Show service status"
      echo "  -p    Show process monitoring"
      echo "  -l    Show system load"
      echo "  -h    Display this help message"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done

# If no options are provided, show the full dashboard
if [ $OPTIND -eq 1 ]; then show_full_dashboard; fi

