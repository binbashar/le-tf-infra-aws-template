#!/usr/bin/env bash

# ----------------------------------------------------------------------------
# - The script simply copies the aws credentials mounted in SRC_AWS_DIR to
# - /root/.aws for AWS cli and Terraform to use, it then passes the control
# - back to the main process
# ----------------------------------------------------------------------------

# Formatting helpers
BOLD="\033[1m"
DATE="\033[0;90m"
ERROR="\033[41;37m"
INFO="\033[0;34m"
DEBUG="\033[0;32m"
RESET="\033[0m"

# Simple logging functions
function error { log "${ERROR}ERROR${RESET}\t$1" 0; }
function info { log "${INFO}INFO${RESET}\t$1" 1; }
function debug { log "${DEBUG}DEBUG${RESET}\t$1" 2; }
function log {
    if [[ $MFA_SCRIPT_LOG_LEVEL -gt "$2" ]]; then
        echo -e "${DATE}[$(date +"%H:%M:%S")]${RESET}   $1"
    fi
}


# Initialize variables
MFA_SCRIPT_LOG_LEVEL=`printenv MFA_SCRIPT_LOG_LEVEL || echo 2`
SRC_AWS_DIR=`printenv SRC_AWS_DIR`
AWS_DIR="/root/.aws"
debug "${BOLD}SRC_AWS_DIR=${RESET}$SRC_AWS_DIR"

# Ensure credentials dir exists
mkdir -p $AWS_DIR

# Copy credentials
if [[ -d "$SRC_AWS_DIR" ]]; then
    cp -r $SRC_AWS_DIR $AWS_DIR
    debug "Copied credentials in path: $AWS_DIR/$(basename $SRC_AWS_DIR)"
fi

# Pass control back to the main process
exec "$@"
