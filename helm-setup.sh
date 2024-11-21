#!/bin/bash
# update-and-publish.sh

set -e  # Exit on any error

# 1. Update from upstream
git checkout development
git fetch upstream
git merge upstream/main

# 2. Update Helm dependencies
cd deployment/helm/charts/danswer
rm -rf charts/
rm -f Chart.lock
helm dependency update

# 3. Package chart
helm package .

# 4. Push to ACR
export ACR_NAME="crazwulouksouthcyhopvstuu4wg"
helm push danswer-stack-*.tgz oci://$ACR_NAME.azurecr.io/helm/danswer

echo "Update complete and chart published to ACR"