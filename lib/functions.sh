#!/bin/bash

#
# Set Cloud API Login Info
#
# Fill in your Cloud API credentials below. You can find these on the
# Credentials tab of your Insight profile: https://accounts.acquia.com/account.
#
email="you@example.com"
key="your-api-key"
endpoint="https://cloudapi.acquia.com/v1"

#
# Log in to Cloud API
#
# Log in to Cloud API using the credentials provided above. This needs to be run
# before running any drush acapi commands.
#
cloudapi_login() {
  drush --email=${email} --endpoint=${endpoint} --key=${key} ac-api-login
}

#
# Back Up Databases
#
# Backs up all databases in the current environment. It is recommended to do this
# before running database updates just in case something goes wrong and you need
# to restore to the previous state.
#
backup_dbs() {
  site="$1"
  target_env="$2"

  echo "Backing up database(s)..."
  for db in $(drush @${site}.${target_env} ac-database-list | awk '{print $3}'); do
    echo "Backing up ${db}..."
    drush @${site}.${target_env} ac-database-instance-backup $db
  done
}

#
# Run Database Updates
#
# Runs all pending database updates. Also clears Drupal caches afterwards.
#
# @TODO Improve this function to run updates for each site in a multisite setup.
#
update_db() {
  site="$1"
  target_env="$2"

  echo "Running database updates..."
  drush @${site}.${target_env} -y updb
}

#
# Clear Drupal Caches
#
# Clears all Drupal caches.
#
# @TODO Improve this function to run updates for each site in a multisite setup.
#
clear_caches() {
  site="$1"
  target_env="$2"

  echo "Clearing Drupal caches..."
  drush @${site}.${target_env} cc all
}

#
# Clear Varnish Caches
#
# Clears the Varnish cache for all domains in the current environment.
#
clear_varnish() {
  site="$1"
  target_env="$2"

  for domain in $(drush @${site}.${target_env} ac-domain-list | awk '{print $3}'); do
    if [[ $domain == *"amazonaws"* ]]; then
      echo "This is an ELB, skipping varnish cache clear for ${domain}..."
    else
      echo "Clearing Varnish cache for ${domain}..."
      drush @${site}.${target_env} ac-domain-purge $domain
    fi
  done
}
