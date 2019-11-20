#!/bin/bash

# Path where the script is currently run
RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# initialising a working directory containing Terraform configuration files
terraform init $RUN_PATH/$1

# get command downloads and updates modules mentioned in the root module
terraform get $RUN_PATH/$1

# plan command creates an execution plan
terraform plan $RUN_PATH/$1