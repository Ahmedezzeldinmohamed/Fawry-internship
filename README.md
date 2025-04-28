
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

# Check if at least two arguments are provided
if [ $# -lt 2 ]; then
  echo "Usage: $0 [-n] [-v] <search_string> <file>"
  exit 1
fi

# Default options
line_numbers=false
invert_match=false

# Parse options
while getopts "nv" opt; do
  case $opt in
    n)
      line_numbers=true
      ;;
    v)
      invert_match=true
      ;;
    *)
      echo "Invalid option. Usage: $0 [-n] [-v] <search_string> <file>"
      exit 1
      ;;
  esac
done

# Remove options from argument list
shift $((OPTIND - 1))

# Get search string and file name
search_string=$1
file=$2

# Check if file exists
if [ ! -f "$file" ]; then
  echo "File not found!"
  exit 1
fi

# Process the file
if $invert_match; then
  grep -i -v "$search_string" "$file" | 
  if $line_numbers; then
    nl
  fi
else
  grep -i "$search_string" "$file" | 
  if $line_numbers; then
    nl
  fi
fi
Run Tests:

./mygrep.sh hello testfile.txt

./mygrep.sh -n hello testfile.txt

./mygrep.sh -vn hello testfile.txt

./mygrep.sh -v testfile.txt

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



