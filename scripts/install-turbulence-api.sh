#!/bin/bash

set -euo pipefail

director_yml=./kubo-lock/metadata
creds_file=./gcs-bosh-creds/creds.yml

bosh-cli -e environment -n -d turbulence deploy ./git-kubo-ci/manifests/turbulence/manifest.yml \
  -v director_ip="$(bosh-cli int "$director_yml"  --path=/internal_ip)" \
  -v director_client=admin \
  -v director_client_secret="$(bosh-cli int "$creds_file" --path=/admin_password)" \
  --var-file director_ssl.ca=<(bosh-cli int "$creds_file" --path=/director_ssl/ca) \
  --vars-store /tmp/creds.yml
