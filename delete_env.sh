#!/bin/bash

#Script to remove some properties

echo "IAAS = " $1
echo "Environment Name = " $2
echo "Domain Name = " $3

if [ $# != 3 ]; then
  echo "This requires 3 arguments i.e : create_new_env.sh gcp new_gcp_environment_name dashaun.cloud"
  exit 1
fi

credhub delete -n /concourse/$2/opsman_admin_password
credhub delete -n /concourse/$2/acme_cert
credhub delete -n /concourse/$2/gcp_credentials_json
credhub delete -n /concourse/$2/project
credhub delete -n /concourse/$2/slack-webhook
credhub delete -n /concourse/$2/decryption_passphrase
credhub delete -n /concourse/$2/opsman_admin_username
credhub delete -n /concourse/$2/git_ssh_key
credhub delete -n /concourse/$2/credhub_password
credhub delete -n /concourse/$2/credhub_username
credhub delete -n /concourse/$2/credhub_ca_cert
credhub delete -n /concourse/$2/credhub_url
credhub delete -n /concourse/$2/pivnet_token
credhub delete -n /concourse/$2/app_terraform_io_token
credhub delete -n /concourse/$2/sendgrid-port
credhub delete -n /concourse/$2/sendgrid-host
credhub delete -n /concourse/$2/sendgrid-api
credhub delete -n /concourse/$2/email
credhub delete -n /concourse/$2/environment_name
credhub delete -n /concourse/$2/iaas
credhub delete -n /concourse/$2/wavefront-token
credhub delete -n /concourse/$2/uaa-wavefront
credhub delete -n /concourse/$2/uaa-wavefront-pass