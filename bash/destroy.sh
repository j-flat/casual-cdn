#!/bin/bash

# Path where the script is currently run
RUN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

terraform init $RUN_PATH/$1

terraform get $RUN_PATH/$1

terraform destroy -auto-approve $RUN_PATH/$1