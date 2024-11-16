#! /bin/bash

#################################################################################################################################################
# This script is used to compare module versions and update the template file if the versions do not match                                      #                                     
# Usage: ./sync_modules.sh <infra_file> <template_file>                                                                                         #                             
# Example: ./sync_modules.sh le-tf-infra-aws/management/global/sso/account_assignments.tf template/management/global/sso/account_assignments.tf #
#################################################################################################################################################

# management/global/sso/account_assignments.tf
# management/primary_region/base-tf-backend/main.tf
# security/primary_region/base-tf-backend/main.tf
# security/primary_region/security-base/account.tf
# shared/primary_region/base-network/network_vpc_flow_logs.tf
# shared/primary_region/base-network/network.tf
# shared/primary_region/base-tf-backend/main.tf

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <infra_file> <template_file>"
  exit 1
fi

# print message that initiate the comparison
echo -e "Initiating comparison:\nInfra file: $1\nTemplate file: $2\n"

# It should comtains the path of the infra file and the template file
INFRA_FILE=$1
TEMPLATE_FILE=$2

if [ -z $TEMPLATE_FILE ]; then
  echo "Template file does not exist"
  exit 1
fi

if [ -z $INFRA_FILE ]; then
  echo "Infra file does not exist"
  exit 1
fi

TEMPLATE_VERSION=$(cat $TEMPLATE_FILE | grep -oP 'ref=\K[^"]*')
INFRA_VERSION=$(cat $INFRA_FILE | grep -oP 'ref=\K[^"]*')

if [ -z $INFRA_VERSION ]; then
  echo "Infra Version value taken from the files is empty"
  exit 1
fi

if [ -z $TEMPLATE_VERSION ]; then
  echo "Template Version value taken from the files is empty"
  exit 1
fi

echo "Current Template Version: $TEMPLATE_VERSION"
echo "Current Infra Version: $INFRA_VERSION"

if [ "$TEMPLATE_VERSION" == "$INFRA_VERSION" ]; then
  echo "Versions match, no need to update"
  exit 0
else
  echo "Versions do not match, updating on template repository"
  sed -i "s/ref=$TEMPLATE_VERSION/ref=$INFRA_VERSION/g" $TEMPLATE_FILE
  git add $TEMPLATE_FILE
  echo "Updated the version in the template repository file to $INFRA_VERSION"
  exit 0
fi
