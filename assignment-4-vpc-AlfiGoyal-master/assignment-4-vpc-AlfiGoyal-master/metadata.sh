#!/bin/bash

# assign variables
ACTION=${1}
version=0.5.0
function show_usage() {
	echo "Usage ${0} {no argument|-h|-v|-c}"
}
function create_logs() {
	touch backend1-identity.json
	curl http://169.254.169.254/latest/dynamic/instance-identity/document/ > backend1-identity.json
	touch backend1-message.txt
	curl -vs https://s3.amazonaws.com/seis665/message.json 2>&1 | tee backend1-message.txt
	scp /var/log/nginx/access.log access.log
}

function show_version() {

echo $version
}

function display_help() {
	cat << EOF
Usage: <filename> {no argument|-c|--create|-h|--help|-v|--version} 
OPTIONS:
	no argument    usage information
	-h | --help	   Display the command help
	-c | --create  Creates backend1-identity.json,  backend1-message.txt, access.log
	-v | --version Displays the version
Examples:
	no argument:
		$ ./metadata.sh
	Display help:
		$ ./metadata.sh -h
	Creating backend1-identity.json,  backend1-message.txt, access.log:
		$ ./metadata.sh -c
	Display version:
		$ ./metadata.sh -v
EOF

}
if [[ $# -eq 0 ]] ; then
	show_usage
    exit 0
fi
case "$ACTION" in
	-h|--help)
		display_help
		;;
	-c|--create)
		create_logs
		;;
	-v|--version)
		show_version
		;;
	*)	
	exit 1
esac
