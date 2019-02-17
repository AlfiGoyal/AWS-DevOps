#!/bin/bash

# assign variables
ACTION=${1}
version=1.0.0

function install_nginx() {
	sudo yum update -y
	sudo amazon-linux-extras install nginx1.12 -y
	sudo chkconfig nginx on
	sudo aws s3 cp s3://alfigoyal-assignment-3/index.html /usr/share/nginx/html/index.html
	sudo service nginx start
}

function show_version() {

echo $version
}

function remove_nginx() {
	sudo service nginx stop
	sudo rm -rf /usr/share/nginx/html/*
	sudo yum remove nginx -y
        sudo rm -rf /etc/nginx/sites-{available,enabled}/default
}

function display_help() {
	cat << EOF
Usage: <filename> {no argument|-c|--create|-h|--help|-d|--delete|-v|--version} 

OPTIONS:
	no argument    Updates all system packages.Installs the Nginx software package.Configures nginx to automatically start at system boot up.
				   Copies the website documents to the web document root directory.Start the Nginx service. 
	-h | --help	   Display the command help
	-r | --remove  Stops the Nginx service.Deletes the files in the website document root directory (/usr/share/nginx/html).Uninstalls the Nginx software package.
	-v | --version Displays the version

Examples:
	no argument:
		$ ./provision.sh

	Display help:
		$ ./provision.sh -h

	Remove nginx:
		$ ./provision.sh -r

	Display version:
		$ ./provision.sh -v
EOF

}
if [[ $# -eq 0 ]] ; then
    install_nginx
    exit 0
fi
case "$ACTION" in
	-h|--help)
		display_help
		;;
	-r|--remove)
		remove_nginx
		;;
	-v|--version)
		show_version
		;;
	*)	
	echo "Usage ${0} {no argument|-h|-v|-r}"
	exit 1
esac
