"""Module to parse json files using python3"""

import json
import sys


def ip_print(var_file_name):
    """ip_print function to print ips depending on keys in a json"""
    try:
        # Read the input JSON file
        with open(var_file_name, 'r', encoding='UTF-8') as file:
            data = json.load(file)
    except FileNotFoundError:
        print(f"Error: The file '{var_file_name}' was not found.")
        sys.exit(1)
    except json.JSONDecodeError:
        print(f"Error: The file '{var_file_name}' contains invalid JSON.")
        sys.exit(1)

    # Extract IP addresses from the "value" object
    try:
        vm_private_ips = data['vm_private_ips']['value']
    except KeyError:
        print("Error: The required 'vm_private_ips' or 'value' key is missing.")
        sys.exit(1)

    # Check if "network" object exists and create a mapping of names to access_ip_v4
    network_ips = {}
    if 'network' in data and 'vms' in data['network']:
        for vm in data['network']['vms']:
            try:
                name = vm['attributes']['name']
                access_ip_v4 = vm['attributes']['access_ip_v4']
                network_ips[name] = access_ip_v4
            except KeyError:
                print("Error: Missing expected keys in 'network' 'vms' objects.")
                sys.exit(1)

    # Print the IP addresses
    print("Value")
    for vm_name, private_ip in vm_private_ips.items():
        if vm_name in network_ips:
            print(f"{private_ip} {network_ips[vm_name]}")
        else:
            print(private_ip)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 ip_print.py FILENAME")
        sys.exit(1)

    var_file_name = sys.argv[1]
    ip_print(var_file_name)
