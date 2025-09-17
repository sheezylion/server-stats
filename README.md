# Server Stats Script

A simple shell script (`server-stats.sh`) that analyzes and displays basic Linux server performance statistics.  
This script can be run on most Linux servers and provides insights into CPU, memory, disk usage, and the top resource-consuming processes.

---

## Features

The script displays the following:

1. **Total CPU Usage** (as a percentage)
2. **Total Memory Usage** (Free vs Used, including percentage)
3. **Total Disk Usage** (Free vs Used, including percentage)
4. **Top 5 Processes by CPU usage**
5. **Top 5 Processes by Memory usage**

---

## Installation & Setup

Clone this repository:

```bash
git clone https://github.com/sheezylion/server-stats.git
cd server-stats
```

### Make the script executable:

```
chmod +x server-stats.sh
```

### Run the script:

```
./server-stats.sh
```

### Example output

```
==============================================
         SERVER PERFORMANCE STATISTICS
==============================================

1. Total CPU Usage:
3.2% used

2. Total Memory Usage:
Used: 184MB / 808MB (22.77%)

3. Total Disk Usage:
Used: 2.6G / 125G (3%)

4. Top 5 Processes by CPU usage:
    PID COMMAND         %CPU
   3822 kworker/0:1-eve  0.1
      1 systemd          0.0
      2 kthreadd         0.0
      3 rcu_gp           0.0
      4 rcu_par_gp       0.0

5. Top 5 Processes by Memory usage:
    PID COMMAND         %MEM
    894 firewalld        5.1
    895 sssd_nss         4.9
    949 tuned            3.8
    858 polkitd          3.2
   3126 NetworkManager   2.3
```

### Requirements

1. **Linux environment (tested on Ubuntu, Debian, CentOS)**

2. **Standard utilities: top, awk, ps, df, free**

### Project URL

👉 [View project] : https://roadmap.sh/projects/server-stats
