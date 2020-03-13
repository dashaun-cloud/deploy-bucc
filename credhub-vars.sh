#!/bin/bash

# Modify/comment out sections which are not needed for your project
# Everything else is required

#General values (required) - we assume sendgrid and cloudflare for homelabs
credhub set --type value --name /concourse/pa/wavefront-token --value <API token>
credhub set --type value --name /concourse/pa/sendgrid-api --value <API token>
credhub set --type value --name /concourse/pa/pivnet_token --value <API token>
credhub set --type ssh --name /concourse/pa/git_ssh_key --public <path to public key> --private <path to private key>
credhub set --type value --name /concourse/pa/cloudflare_email --value <account email>
credhub set --type value --name /concourse/pa/cloudflare_key --value <API token>
credhub set --type value --name /concourse/pa/email --value <notification email>
credhub set --type value --name /concourse/pa/app_terraform_io_token --value <API token>
credhub set --type value --name /concourse/pa/app_terraform_io_org --value <terraform org>

#AWS specific values (comment if not needed)
credhub set --type value --name /concourse/pa/aws_secret_key --value <aws secret>
credhub set --type value --name /concourse/pa/aws_access_key --value <aws key>

#Azure specific values (comment if not needed)
credhub set --type value --name /concourse/pa/azure_cf_resource_group_name --value <resource group>
credhub set --type value --name /concourse/pa/azure_cf_storage_account_name --value <storage account>
credhub set --type value --name /concourse/pa/azure_subscription_id --value <subscription id>
credhub set --type value --name /concourse/pa/azure_client_secret --value <client secret>
credhub set --type value --name /concourse/pa/azure_client_id --value <client id>
credhub set --type value --name /concourse/pa/azure_tenant_id --value <tenant id>
credhub set --type value --name /concourse/pa/azure_terraform_container_name --value <tf container name> 
credhub set --type value --name /concourse/pa/azure_terraform_resource_group_name --value <tf resource group>
credhub set --type value --name /concourse/pa/azure_terraform_storage_account_name --value <tf storage account>
credhub set --type value --name /concourse/pa/azure_access_key --value <access key>

#GCP specific values (comment if not needed)
credhub set --type value --name /concourse/pa/gcp_credentials_json --value <'<gcp json payload>'>
credhub set --type value --name /concourse/pa/project --value <project name in gcp>

# Values specific to VSphere on-prem environments (comment if not needed)
credhub set --type value --name /concourse/pa/network_dns --value <dns address>
credhub set --type value --name /concourse/pa/network_netmask --value <netmask>
credhub set --type value --name /concourse/pa/network_gateway --value <gateway address>
credhub set --type value --name /concourse/pa/opsman_private_ip --value <internal opsman ip>
credhub set --type value --name /concourse/pa/minio_endpoint --value <minio endpoint>
credhub set --type value --name /concourse/pa/minio_secret_key --value <secret key>
credhub set --type value --name /concourse/pa/minio_access_key --value <access key>
credhub set --type ssh --name /concourse/pa/buccbox_ssh_pub  --public <path to public key> --private <path to private key>
credhub set --type value --name /concourse/pa/vcenter_network --value <network name in vsphere>
credhub set --type value --name /concourse/pa/vcenter_folder --value <vcenter folder name>
credhub set --type value --name /concourse/pa/vcenter_host --value <vcenter hostname>
credhub set --type value --name /concourse/pa/vcenter_url --value <vcenter url (https://hostname)>
credhub set --type value --name /concourse/pa/vcenter_user --value <full sso user name (administrator@domain)>
credhub set --type value --name /concourse/pa/vcenter_password --value <password>
credhub set --type value --name /concourse/pa/vcenter_datastore --value <vcenter datastore>
credhub set --type value --name /concourse/pa/vcenter_dc --value <vcenter datacenter name>
credhub set --type value --name /concourse/pa/opsman_hostname --value <hostname for opsman>
credhub set --type value --name /concourse/pa/opsman_vm_name --value <vm name for opsman>
credhub set --type value --name /concourse/pa/vcenter_rp --value <vcenter resource pool>

