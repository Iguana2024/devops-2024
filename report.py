import os
import netifaces as ni

def get_interface_ip(interface_name):
    """Get the IP address of a specific network interface."""
    try:
        interface_addresses = ni.ifaddresses(interface_name)
        ip_info = interface_addresses[ni.AF_INET][0]
        ip_address = ip_info['addr']
        return ip_address
    except (ValueError, KeyError):
        print(f"Error: Could not retrieve IP for interface {interface_name}.")
        return None

# Specify the full path to the input file
input_file_path = "/var/tmp/sftp.log"

# Determine the output file based on the host's specific interface IP
host_ip = get_interface_ip('enp0s8')
if host_ip is None:
    print("Specific network interface IP not found, script will exit.")
    exit(1)  # Exit script if no IP found

output_file_path = f"/vagrant/report_{host_ip.replace('.', '_')}.txt"


with open(input_file_path, "r") as file:
    logs = file.readlines()

# Process the logs to count IP addresses and hostnames
host_ip_count = {}
for log in logs:
    parts = log.split(", ")
    hostname = parts[2].split(": ")[1]
    ip_address = parts[3].split(": ")[1]
    key = f"{hostname} ({ip_address})"  

    if key in host_ip_count:
        host_ip_count[key] += 1
    else:
        host_ip_count[key] = 1

# Generate the report content
report = "Machine Name".ljust(25) + "IP Address".ljust(25) + "Count\n"
for key, count in sorted(host_ip_count.items()):
    hostname, ip_address = key.split(" (")
    ip_address = ip_address[:-1]  
    report += f"{hostname.ljust(25)}{ip_address.ljust(25)}{str(count).ljust(25)}\n"

# Write the report to the specified output file
with open(output_file_path, "w") as file:
    file.write(report)
