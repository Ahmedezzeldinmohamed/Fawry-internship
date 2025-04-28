
# Fawry-internship
Fawry Internship Tasks

Task Solutions Repository
This repository contains the solutions for two tasks: Q1 - Custom Command (mygrep.sh) and Q2 - Troubleshooting DNS and Network Connectivity.

Q1: 🛠️ Custom Command: mygrep.sh
Task Description
Build a mini version of the grep command. Your script will be called mygrep.sh and must support:

Search for a string (case-insensitive).

Print matching lines from a text file.

Command-Line Options:

-n → Show line numbers for each match.

-v → Invert the match (print lines that do not match).

Combinations like -vn, -nv should work the same as using -v -n.

Steps
Create the script mygrep.sh.

touch mygrep.sh
chmod +x mygrep.sh
Script Code (mygrep.sh):

==========================================

#!/bin/bash

show_help() {
    echo "Usage: $0 [-n] [-v] search_string filename"
}

if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
fi

options=""
while [[ "$1" == -* ]]; do
    options="$options$1"
    shift
done

if [ $# -lt 2 ]; then
    echo "Error: Missing search string or filename"
    show_help
    exit 1
fi

search="$1"
file="$2"

if [ ! -f "$file" ]; then
    echo "Error: File not found!"
    exit 1
fi

grep_command="grep -i"

if [[ "$options" == *v* ]]; then
    grep_command="$grep_command -v"
fi

if [[ "$options" == *n* ]]; then
    grep_command="$grep_command -n"
fi

$grep_command "$search" "$file"

================================================

Q2: 🌐 Troubleshooting Internal Web Dashboard Connectivity

Task Description
The internal web dashboard hosted on internal.example.com is unreachable from multiple systems. The service seems to be up, but users get “host not found” errors. The task is to troubleshoot, verify, and restore connectivity to the internal service.

Steps
Verify DNS Resolution:


Check DNS resolution using local DNS:
cat /etc/resolv.conf


Compare with Google DNS (8.8.8.8):
nslookup internal.example.com 8.8.8.8


Diagnose Service Reachability:
Find the IP address using dig or nslookup.


nslookup internal.example.com
Check if the service is listening on port 80/443 using telnet or curl:


curl http://<resolved-ip>


telnet <resolved-ip> 80


Confirm the service is listening:


ss -tuln | grep 80


Trace the Issue – Possible Causes:
DNS misconfiguration: Check /etc/resolv.conf and DNS server.

Firewall/Network restrictions: Ensure ports 80/443 are open and accessible.

Service not listening: Check service status.

Propose and Apply Fixes:
Fix DNS issues by correcting /etc/resolv.conf.

Open the firewall ports if blocked using:

sudo ufw allow 80/tcp
sudo ufw allow 443/tcp


Restart the service if not running:

sudo systemctl restart apache2


Bonus:
Modify /etc/hosts to bypass DNS:

sudo nano /etc/hosts

Add the following line:

<resolved-ip> internal.example.com



