#!/bin/bash

show_help() {
	echo "ONLY UBUNTU BASE DISTRIBUTIONS!!!"
	echo ""
	echo "Setup a new DNS to the ubuntu."
	echo ""
	echo "Syntax: bash scriptname [options|DNS]"
	echo "The option available to this script is:"
	echo "    -h    Show this help message"
	echo ""
	echo "Example of this script to setup google DNS:"
	echo "        $ bash setup_dns.sh 8.8.8.8"
}

while getopts ":h" option; do
	case $option in
		h)
			show_help
			exit 0
			;;
	esac
done

if [ -z "$1" ]; then
	echo 1>&2 "Error: please pass the DNS argument, if you need help please try the -h argument to more information."
	exit 2
fi

# ASK FOR SUPER USER PERMISIONS
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"

# MAKE SURE THE NETWORK IS working
apt install network-manager
systemctl restart networking

# CREATE A TEMP FILE WITH NEW DNS CONF
touch "/etc/resolv1.conf"
echo "nameserver $1" >> "/etc/resolv1.conf"
echo "options edns0 trust-ad" >> "/etc/resolv1.conf"
echo "search ." >> "/etc/resolv1.conf"

# SUBSTITUTE THE DNS FILE
rm "/etc/resolv.conf"
mv "/etc/resolv1.conf" "/etc/resolv.conf"
