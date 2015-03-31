#!/bin/bash
#
# Cloud Hook Update Script
#
# This script contains the most common functions which need to be performed
# after an operation is completed such as deploying or updating code, copying
# databases, or copying files.
#
# Use the ones you want and comment out the ones you don't. The functions being
# called in this script are in [hooks directory]/lib/functions.sh.
#

#
# These arguments are available for every hook.
#
site="$1"
target_env="$2"

#
# These arguments are available for post-code-deploy and post-code-update.
#
# source_branch="$3"
# deployed_tag="$4"
# repo_url="$5"
# repo_type="$6"

#
# These arguments are available for post-db-copy.
#
# db_name="$3"
# source_env="$4"

#
# These arguments are available for post-files-copy.
#
# source_env="$3"

#
# Include functions library contained in ../../lib/functions.sh.
#
source `dirname $0`/../../lib/functions.sh

#
# Log In To Cloud API
#
# Log in to Cloud API so we don't have to provide the creds in every
# drush acapi call.
#
# To see a list of available Cloud API drush commands, run:
# drush help --filter=acapi
#
cloudapi_login

#
# Back Up Databases
#
backup_dbs ${site} ${target_env}

#
# Run Database Updates
#
update_db ${site} ${target_env}

#
# Clear Drupal Caches
#
# clear_caches ${site} ${target_env}

#
# Clear Varnish Caches
#
clear_varnish ${site} ${target_env}
