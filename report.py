# report.py
import os

# Specify the full path to the input and output files
input_file_path = "/var/tmp/sftp.log"
output_file_path = "/vagrant/report.txt"

# Read the log data
with open(input_file_path, "r") as file:
    logs = file.readlines()

# Process the logs to count IP addresses and hostnames
host_ip_count = {}
for log in logs:
    parts = log.split(", ")
    hostname = parts[2].split(": ")[1]
    ip_address = parts[3].split(": ")[1]
    key = f"{hostname} ({ip_address})"  # Combine hostname and IP for uniqueness

    if key in host_ip_count:
        host_ip_count[key] += 1
    else:
        host_ip_count[key] = 1

# Generate the report content
report = "Machine Name".ljust(25) + "IP Address".ljust(25) + "Count\n"
for key, count in sorted(host_ip_count.items()):
    hostname, ip_address = key.split(" (")
    ip_address = ip_address[:-1]  # Remove the closing parenthesis
    report += f"{hostname.ljust(25)}{ip_address[:-1].ljust(25)}{str(count).ljust(25)}\n"

# Write the report to the specified output file
with open(output_file_path, "w") as file:
    file.write(report)