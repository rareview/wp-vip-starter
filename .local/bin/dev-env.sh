#!/usr/bin/env bash

OS=`uname`
# $(replace_in_file pattern file)
function replace_in_file() {
    if [ "$OS" = 'Darwin' ]; then
        # for MacOS
        sed -i '' -e "$1" "$2"
    else
        # for Linux and Windows
        sed -i'' -e "$1" "$2"
    fi
}

# Exit if any command fails.
set -e

print_style () {
    if [[ "$2" == "info" ]] ; then
        COLOR="96m"
    elif [[ "$2" == "success" ]] ; then
        COLOR="92m"
    elif [[ "$2" == "warning" ]] ; then
        COLOR="93m"
    elif [[ "$2" == "danger" ]] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    START_COLOR="\e[$COLOR"
    END_COLOR="\e[0m"

    printf "$START_COLOR%b$END_COLOR" "$1"
}

usage() {
	echo "usage: $0 command"
	echo "  init	                                Init the dev environment"
	echo "  destroy                                 Destroy the dev environment"
	echo "  start                                   Start the dev environment"
	echo "  stop                                    Stop the dev environment"
	echo "  exec                                    Execute an operation on a dev environment"
	echo "  wp                                      Execute WP-CLI on a dev environment"
	echo "  info                                    Provides basic info about the dev environment"
	echo "  db-import <file.sql>                    Import a SQL file into the dev environment"
	echo '  db-search-replace <file.sql> [options]  Perform a search and replace on a SQL file. The required options are: -s="from,to" -o="<output.sql>"'
	echo "  -h | usage  Output this message"
	exit 1
}

SLUG="rv-starter"
REPO_DIR=$(basename "$(pwd)")
ENV_CONFIG_DIR="$(pwd)/.local/site"
init_env() {
	print_style "Installing composer root dependencies...\n" "success"
	composer install
	print_style "Installing theme composer dependencies...\n" "success"
    composer install --working-dir=themes/rv-starter
	print_style "Installing project npm dependencies...\n" "success"
	npm install
	print_style "Installing theme npm dependencies...\n" "success"
	npm install --prefix themes/rv-starter
	print_style "Initializing the '${REPO_DIR}' VIP local environment...\n" "success"
	vip --slug="${SLUG}" dev-env create
	ENV_DIR=$(vip --slug="${SLUG}" dev-env info | awk '/LOCATION/ {print $2}')
	print_style "Creating a symlink from ${ENV_DIR} to ${ENV_CONFIG_DIR}\n" "success"
	ln -s "${ENV_DIR}" "${ENV_CONFIG_DIR}"
	print_style "Setup config files...\n" "success"
	mkdir "${ENV_CONFIG_DIR}/config"
	cp ".local/wp-config.template.php" "${ENV_CONFIG_DIR}/config/wp-config.php"
	cp ".local/wp-config-defaults.template.php" "${ENV_CONFIG_DIR}/config/wp-config-defaults.php"
	replace_in_file "s/DEV_DOMAIN_PLACEHOLDER/${SLUG}/" "${ENV_CONFIG_DIR}/config/wp-config.php"
	print_style "Setup the ./client-mu-plugins/wp-local-dev.php plugin...\n" "success"
	cp ".local/wp-local-dev.template.php" ./client-mu-plugins/wp-local-dev.php
	replace_in_file "s/DEV_DOMAIN_PLACEHOLDER/${SLUG}/" ./client-mu-plugins/wp-local-dev.php
}

destroy_env() {
	print_style "Removing composer vendor folders...\n" "success"
	rm -rf $(pwd)/client-mu-plugins/vendor $(pwd)/themes/rv-starter/vendor
	print_style "Removing the node_modules folders...\n" "success"
	rm -rf $(pwd)/node_modules $(pwd)/themes/rv-starter/node_modules
	ENV_DIR=$(vip --slug="${SLUG}" dev-env info | awk '/LOCATION/ {print $2}')
	print_style "Destroying the '${REPO_DIR}' VIP local environment...\n" "success"
	vip --slug="${SLUG}" dev-env destroy
	print_style "Removing the ${ENV_CONFIG_DIR} symlink...\n" "success"
	rm -rf "${ENV_CONFIG_DIR}"
	print_style "Removing ${ENV_DIR}...\n" "success"
	rm -rf "${ENV_DIR}"
	print_style "Removing the ./client-mu-plugins/wp-local-dev.php plugin...\n" "success"
	rm -f ./client-mu-plugins/wp-local-dev.php
}

start_env() {
	print_style "Starting the ${REPO_DIR} VIP local environment...\n" "success"
	vip --slug="${SLUG}" dev-env start
	print_style "WordPress Credentials: Username: vipgo \t Password: password\n" "success"
}

stop_env() {
	print_style "Stopping the ${REPO_DIR} VIP local environment...\n" "success"
	vip --slug="${SLUG}" dev-env stop
}

exec_env() {
	vip --slug="${SLUG}" dev-env exec -- "${@:1}"
}

exec_wp_env() {
	vip --slug="${SLUG}" dev-env exec -- wp "${@:1}"
}

info_env() {
	vip --slug="${SLUG}" dev-env info
}

db_import_env() {
	vip --slug="${SLUG}" dev-env import sql "${@:1}"
}

db_search_replace_env() {
	vip search-replace "${@:1}"
}

if [ "${1}" == "init" ]; then
	init_env "${@:2}"
elif [ "${1}" == "destroy" ]; then
	destroy_env
elif [ "${1}" == "start" ]; then
	start_env
elif [ "${1}" == "stop" ]; then
	stop_env
elif [ "${1}" == "exec" ]; then
	exec_env "${@:2}"
elif [ "${1}" == "wp" ]; then
	exec_wp_env "${@:2}"
elif [ "${1}" == "info" ]; then
	info_env
elif [ "${1}" == "db-import" ]; then
	db_import_env "${@:2}"
elif [ "${1}" == "db-search-replace" ]; then
	db_search_replace_env "${@:2}"
else
	usage
fi
