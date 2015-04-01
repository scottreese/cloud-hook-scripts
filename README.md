## What Are Cloud Hook Scripts?
This is a collection of functions and a sample script which leverages the Acquia Cloud API to perform common tasks in response to regular site management operations performed in the Acquia Cloud Workflow. This package is meant to complement the [Acquia Cloud Hooks](https://github.com/acquia/cloud-hooks) package by providing an extensible "plug and play" solution to help developers get started using Acquia Cloud Hooks and Acquia Cloud API in their projects.

By default, the sample script will do the following:
* Back up all databases in the target environment.
* Run all database updates.
* Clear all Drupal caches.
* Clear the Varnish cache for all domains associated with the target environment.

## Installation
1. Follow the [instructions](https://github.com/acquia/cloud-hooks/blob/master/README.md.) to set up Acquia Cloud Hooks in your repository.
2. Download the Cloud Hook Scripts [zip file](https://github.com/scottreese/cloud-hook-scripts/archive/master.zip).
3. Extract the contents of the zip file into your Acquia Cloud Hooks directory (e.g. /my/repo/hooks).

## Usage
1. Edit [lib/functions.sh](https://github.com/scottreese/cloud-hook-scripts/blob/master/lib/functions.sh) and enter your Acquia Cloud API credentials (email and API key). These can be found on the Credentials tab of your [Acquia Account Profile](https://accounts.acquia.com/account).
2. Copy the [samples/env-update.sh](https://github.com/scottreese/cloud-hook-scripts/blob/master/samples/env-update.sh) script to the [env]/[hook] directories for which you want to automatically run these tasks (e.g. hooks/common/post-code-update).
3. Customize the env-update.sh scripts in your hook directories to suit your needs. If you don't need or want to run one of the functions, just comment it out.
4. Add your own functions to lib/functions.sh that you can then call in your env-update.sh scripts.
