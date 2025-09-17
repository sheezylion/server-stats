#!/bin/bash
# A script to gather and display server statistics
#!/bin/bash
# Script: server-stats.sh
# Purpose: Analyze and display basic Linux server performance statistics

echo "=============================================="
echo "         SERVER PERFORMANCE STATISTICS        "
echo "=============================================="

# CPU Usage
echo
echo "1. Total CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "% used"}'

# Memory Usage
echo
echo "2. Total Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB / %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

# Disk Usage
echo
echo "3. Total Disk Usage:"
df -h / | awk 'NR==2{printf "Used: %s / %s (%s)\n", $3, $2, $5}'

# Top 5 CPU-consuming processes
echo
echo "4. Top 5 Processes by CPU usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Memory-consuming processes
echo
echo "5. Top 5 Processes by Memory usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
