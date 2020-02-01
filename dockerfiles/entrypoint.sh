#!/bin/bash

# gitlab-runner data directory
DATA_DIR="/etc/gitlab-runner"
CONFIG_FILE=${CONFIG_FILE:-$DATA_DIR/config.toml}
# custom certificate authority path
CA_CERTIFICATES_PATH=${CA_CERTIFICATES_PATH:-$DATA_DIR/certs/ca.crt}
LOCAL_CA_PATH="/usr/local/share/ca-certificates/ca.crt"

update_ca() {
  echo "Updating CA certificates..."
  cp "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}"
  update-ca-certificates --fresh >/dev/null
}

if [ -f "${CA_CERTIFICATES_PATH}" ]; then
  # update the ca if the custom ca is different than the current
  cmp --silent "${CA_CERTIFICATES_PATH}" "${LOCAL_CA_PATH}" || update_ca
fi


# register gitlab-runner
gitlab-runner register \
--non-interactive \
--url "https://your_gitlab.com/" \
--registration-token "Pv2E3UjtEZt18XtLpdyw" \
--executor "kubernetes" \
--kubernetes-image "alpine:latest" \
--description "kubernetes runner" \
--tag-list "test" \
--run-untagged="true" \
--locked="false" \
--kubernetes-pull-policy "if-not-present" \
--kubernetes-image-pull-secrets "regsecret" \
--kubernetes-helper-image "gitlab-runner-helper:x86_64-4745a6f3" \
--kubernetes-namespace ci

sleep 2

# launch gitlab-runner
/usr/bin/dumb-init gitlab-runner run --user=gitlab-runner --working-directory=/home/gitlab-runner
