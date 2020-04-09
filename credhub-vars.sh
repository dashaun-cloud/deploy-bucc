#!/bin/bash
# This script deletes values if they are there
# If there is no value to delete credhub CLI outputs a warning - we don't care about the warning - so we redirect that output to /dev/null on the deletes
# Modify/comment out sections which are not needed for your project
credhub delete -n /concourse/pa/wavefront-token &>/dev/null
credhub set --type value --name /concourse/pa/wavefront-token --value "${WAVEFRONT_TOKEN}"
credhub delete -n /concourse/pa/sendgrid-api &>/dev/null
credhub set --type value --name /concourse/pa/sendgrid-api --value "${SENDGRID_TOKEN}"
credhub delete -n /concourse/pa/pivnet_token &>/dev/null
credhub set --type value --name /concourse/pa/pivnet_token --value "${PIVNET_TOKEN}"
credhub delete -n /concourse/pa/git_ssh_key &>/dev/null
credhub set --type ssh   --name /concourse/pa/git_ssh_key --public "${SSH_PUBLIC_PATH}" --private "${SSH_PRIVATE_PATH}"
credhub delete -n /concourse/pa/cloudflare_email &>/dev/null
credhub set --type value --name /concourse/pa/cloudflare_email --value "${CLOUDFLARE_EMAIL}"
credhub delete -n /concourse/pa/cloudflare_key &>/dev/null
credhub set --type value --name /concourse/pa/cloudflare_key --value "${CLOUDFLARE_KEY}"
credhub delete -n /concourse/pa/email &>/dev/null
credhub set --type value --name /concourse/pa/email --value "${NOTIFICATION_EMAIL}"
credhub delete -n /concourse/pa/app_terraform_io_token &>/dev/null
credhub set --type value --name /concourse/pa/app_terraform_io_token --value "${TERRAFORM_IO_TOKEN}"
credhub delete -n /concourse/pa/app_terraform_io_org &>/dev/null
credhub set --type value --name /concourse/pa/app_terraform_io_org --value "${TERRAFORM_IO_ORG}"
#AWS specific values (comment if not needed)
credhub delete -n /concourse/pa/aws_secret_key &>/dev/null
credhub set --type value --name /concourse/pa/aws_secret_key --value "${AWS_SECRET_KEY}"
credhub delete -n /concourse/pa/aws_access_key &>/dev/null
credhub set --type value --name /concourse/pa/aws_access_key --value "${AWS_ACCESS_KEY}"
#Azure specific values (comment if not needed)
credhub delete -n /concourse/pa/azure_cf_resource_group_name &>/dev/null
credhub set --type value --name /concourse/pa/azure_cf_resource_group_name --value "${AZURE_CF_RESOURCE_GROUP_NAME}"
credhub delete -n /concourse/pa/azure_cf_storage_account_name &>/dev/null
credhub set --type value --name /concourse/pa/azure_cf_storage_account_name --value "${AZURE_CF_STORAGE_ACCOUNT_NAME}"
credhub delete -n /concourse/pa/azure_subscription_id &>/dev/null
credhub set --type value --name /concourse/pa/azure_subscription_id --value "${AZURE_SUBSCRIPTION_ID}"
credhub delete -n /concourse/pa/azure_client_secret &>/dev/null
credhub set --type value --name /concourse/pa/azure_client_secret --value "${AZURE_CLIENT_SECRET}"
credhub delete -n /concourse/pa/azure_client_id &>/dev/null
credhub set --type value --name /concourse/pa/azure_client_id --value "${AZURE_CLIENT_ID}"
credhub delete -n /concourse/pa/azure_tenant_id &>/dev/null
credhub set --type value --name /concourse/pa/azure_tenant_id --value "${AZURE_TENANT_ID}"
credhub delete -n /concourse/pa/azure_terraform_container_name &>/dev/null
credhub set --type value --name /concourse/pa/azure_terraform_container_name --value "${AZURE_TERRAFORM_CONTAINER_NAME}"
credhub delete -n /concourse/pa/azure_terraform_resource_group_name &>/dev/null
credhub set --type value --name /concourse/pa/azure_terraform_resource_group_name --value "${AZURE_TERRAFORM_RESOURCE_GROUP_NAME}"
credhub delete -n /concourse/pa/azure_terraform_storage_account_name &>/dev/null
credhub set --type value --name /concourse/pa/azure_terraform_storage_account_name --value "${AZURE_TERRAFORM_STORAGE_ACCOUNT_NAME}"
credhub delete -n /concourse/pa/azure_access_key &>/dev/null
credhub set --type value --name /concourse/pa/azure_access_key --value "${AZURE_ACCESS_KEY}"
#GCP specific values (comment if not needed)
credhub delete -n /concourse/pa/gcp_credentials_json &>/dev/null
credhub set --type value --name /concourse/pa/gcp_credentials_json --value "${GCP_CREDENTIALS_JSON}"
credhub delete -n /concourse/pa/project &>/dev/null
credhub set --type value --name /concourse/pa/project --value "${GCP_PROJECT_NAME}"
# Values specific to VSphere on-prem environments (comment if not needed)
#credhub set --type value --name /concourse/pa/homelab_dns --value <dns address>
#credhub set --type value --name /concourse/pa/homelab_netmask --value <netmask>
#credhub set --type value --name /concourse/pa/homelab_gateway --value <gateway address>
#credhub set --type value --name /concourse/pa/opsman_private_ip --value <internal opsman ip>
#credhub set --type value --name /concourse/pa/minio_endpoint --value <minio endpoint>
#credhub set --type value --name /concourse/pa/minio_secret_key --value <secret key>
#credhub set --type value --name /concourse/pa/minio_access_key --value <access key>
#credhub set --type ssh --name /concourse/pa/homelab_ssh_pub  --public <path to public key> --private <path to private key>
#credhub set --type value --name /concourse/pa/homelab_network --value <network name in vsphere>
#credhub set --type value --name /concourse/pa/vcenter_folder --value <vcenter folder name>
#credhub set --type value --name /concourse/pa/vcenter_host --value <vcenter hostname>
#credhub set --type value --name /concourse/pa/vcenter_url --value <vcenter url (https://hostname)>
#credhub set --type value --name /concourse/pa/vcenter_user --value <full sso user name (administrator@domain)>
#credhub set --type value --name /concourse/pa/vcenter_datastore --value <vcenter datastore>
#credhub set --type value --name /concourse/pa/vcenter_dc --value <vcenter datacenter name>
#credhub set --type value --name /concourse/pa/opsman_hostname --value <hostname for opsman>
#credhub set --type value --name /concourse/pa/opsman_vm_name --value <vm name for opsman>
#credhub set --type value --name /concourse/pa/vcenter_rp --value <vcenter resource pool>