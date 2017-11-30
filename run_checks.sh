#!/bin/bash
##########################################################################
# Copyright 2017 Brad Geesaman
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -o errexit
set -o pipefail
set -o nounset

PLUGIN_NAME="${PLUGIN_NAME:-bulkhead}"
RESULTS_DIR="${RESULTS_DIR:-/tmp/results}"

# If this is a master
if [[ "$(pgrep apiserver)" -gt 0 ]]; then
  ./kube-bench master --json >> "${RESULTS_DIR}/master.json"
fi
# If this is a node
if [[ "$(pgrep kubelet)" -gt 0 ]]; then
  ./kube-bench node --json >> "${RESULTS_DIR}/node.json"
fi

# Gather results into one file
cd ${RESULTS_DIR}
tar -czf ${PLUGIN_NAME}.tar.gz * 

# Let the sonobuoy worker know the job is done
echo -n "${RESULTS_DIR}/${PLUGIN_NAME}.tar.gz" >"${RESULTS_DIR}/done"

