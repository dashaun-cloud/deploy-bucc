#!/bin/bash

### Assuming Ubuntu 18.04 | 19.04 | 19.10
### These steps should allow this script to work
#sudo apt update
#sudo apt install software-properties-common
#sudo add-apt-repository universe
#sudo add-apt-repository ppa:certbot/certbot
#sudo apt install certbot python3-certbot-dns-cloudflare -y

echo "IAAS = " $1
echo "Environment Name = " $2
echo "Domain Name = " $3

if [ $# != 3 ]; then
  echo "This requires 3 arguments i.e : create_new_env.sh gcp new_gcp_environment_name dashaun.cloud"
  exit 1
fi

echo "Adding $2 environment in $1 cloud for $3 domain"
credhub delete -n /concourse/$2/iaas &>/dev/null
credhub set -n /concourse/$2/iaas -t value -v $1

credhub delete -n /concourse/$2/environment_name &>/dev/null
credhub set -n /concourse/$2/environment_name -t value -v $2

credhub delete -n /concourse/$2/email &>/dev/null
credhub set -n /concourse/$2/email -t value -v "$(credhub get -n /concourse/pa/email -j | jq .value)"

echo "Adding app.terraform.io"
credhub delete -n /concourse/$2/app_terraform_io_token &>/dev/null
credhub set -n /concourse/$2/app_terraform_io_token -t value -v "$(credhub get -n /concourse/pa/app_terraform_io_token -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
credhub set -n /concourse/$2/app_terraform_io_org -t value -v "$(credhub get -n /concourse/pa/app_terraform_io_org -j | jq .value)"

echo "Adding Pivnet token"
credhub delete -n /concourse/$2/pivnet_token &>/dev/null
credhub set -n /concourse/$2/pivnet_token -t value -v "$(credhub get -n /concourse/pa/pivnet_token -j | jq .value)"

echo "Adding CredHub vals"
credhub delete -n /concourse/$2/credhub_url &>/dev/null
credhub set -n /concourse/$2/credhub_url -t value -v "$(credhub get -n /concourse/main/credhub_url -j | jq .value)"

credhub delete -n /concourse/$2/credhub_ca_cert &>/dev/null
credhub set -n /concourse/$2/credhub_ca_cert -t value -v "$(credhub get -n /concourse/main/credhub_ca_cert -j | jq .value)"

credhub delete -n /concourse/$2/credhub_username &>/dev/null
credhub set -n /concourse/$2/credhub_username -t value -v "$(credhub get -n /concourse/main/credhub_username -j | jq .value)"

credhub delete -n /concourse/$2/credhub_password &>/dev/null
credhub set -n /concourse/$2/credhub_password -t value -v "$(credhub get -n /concourse/main/credhub_password -j | jq .value)"

echo "Adding git ssh key"
credhub delete -n /concourse/$2/git_ssh_key &>/dev/null
credhub set -n /concourse/$2/git_ssh_key -t value -v "$(credhub get -n /concourse/pa/git_ssh_key -j | jq .value.private_key)"

echo "Adding OpsManager credentials"
credhub delete -n /concourse/$2/opsman_admin_username &>/dev/null
credhub set -n /concourse/$2/opsman_admin_username -t value -v admin

credhub delete -n /concourse/$2/opsman_admin_password &>/dev/null
credhub generate -n /concourse/$2/opsman_admin_password -t password

echo "Adding Decryption Passphrase"
credhub delete -n /concourse/$2/decryption_passphrase &>/dev/null
credhub generate -n /concourse/$2/decryption_passphrase -t password

if [ "$1" = "gcp" ]; then
  echo "Adding GCP vals"
credhub delete -n /concourse/$2/project &>/dev/null
  credhub set -n /concourse/$2/project -t value -v "$(credhub get -n /concourse/pa/project -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/gcp_credentials_json -t value -v "$(credhub get -n /concourse/pa/gcp_credentials_json -j | jq .value)"
fi

if [ "$1" = "aws" ]; then
  echo "Adding AWS vals"
credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/aws_access_key -t value -v "$(credhub get -n /concourse/pa/aws_access_key -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/aws_secret_key -t value -v "$(credhub get -n /concourse/pa/aws_secret_key -j | jq .value)"
fi

if [ "$1" = "azure" ]; then
  echo "Adding Azure vals"
credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_access_key -t value -v "$(credhub get -n /concourse/pa/azure_access_key -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_cf_resource_group_name -t value -v "$(credhub get -n /concourse/pa/azure_cf_resource_group_name -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_cf_storage_account_name -t value -v "$(credhub get -n /concourse/pa/azure_cf_storage_account_name -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_client_id -t value -v "$(credhub get -n /concourse/pa/azure_client_id -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_client_secret -t value -v "$(credhub get -n /concourse/pa/azure_client_secret -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_subscription_id -t value -v "$(credhub get -n /concourse/pa/azure_subscription_id -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_tenant_id -t value -v "$(credhub get -n /concourse/pa/azure_tenant_id -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_terraform_container_name -t value -v "$(credhub get -n /concourse/pa/azure_terraform_container_name -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_terraform_resource_group_name -t value -v "$(credhub get -n /concourse/pa/azure_terraform_resource_group_name -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set -n /concourse/$2/azure_terraform_storage_account_name -t value -v "$(credhub get -n /concourse/pa/azure_terraform_storage_account_name -j | jq .value)"
fi

if [ "$1" = "vsphere" ]; then
  echo "Adding VSphere vals"
credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/homelab_dns --value "$(credhub get -n /concourse/pa/homelab_dns -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/homelab_netmask --value "$(credhub get -n /concourse/pa/homelab_netmask -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/homelab_gateway --value "$(credhub get -n /concourse/pa/homelab_gateway -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/opsman_private_ip --value "$(credhub get -n /concourse/pa/opsman_private_ip -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/minio_endpoint --value "$(credhub get -n /concourse/pa/minio_endpoint -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/minio_secret_key --value "$(credhub get -n /concourse/pa/minio_secret_key -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/minio_access_key --value "$(credhub get -n /concourse/pa/minio_access_key -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/homelab_ssh_pub  --value "$(credhub get -n /concourse/pa/homelab_ssh_pub -j | jq .value.public_key)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/homelab_network --value "$(credhub get -n /concourse/pa/homelab_network -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_folder --value "$(credhub get -n /concourse/pa/vcenter_folder -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_host --value "$(credhub get -n /concourse/pa/vcenter_host -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_url --value "$(credhub get -n /concourse/pa/vcenter_url -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type user --name /concourse/$2/vcenter_user --username "$(credhub get -n /concourse/pa/vcenter_user -j | jq .value)" --password "$(credhub get -n /concourse/pa/vcenter_password -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_datastore --value "$(credhub get -n /concourse/pa/vcenter_datastore -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_dc --value "$(credhub get -n /concourse/pa/vcenter_dc -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/opsman_hostname --value "$(credhub get -n /concourse/pa/opsman_hostname -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/opsman_vm_name --value "$(credhub get -n /concourse/pa/opsman_vm_name -j | jq .value)"

credhub delete -n /concourse/$2/app_terraform_io_org &>/dev/null
  credhub set --type value --name /concourse/$2/vcenter_rp --value "$(credhub get -n /concourse/pa/vcenter_rp -j | jq .value)"
fi 

echo "Right now we are assuming that your domain name is managed by CloudFlare"

# Create temporary cloudflare.ini file
echo "dns_cloudflare_email = "$(credhub get -n /concourse/pa/cloudflare_email -j | jq .value)"" >> ./cloudflare.ini
echo "dns_cloudflare_api_key = "$(credhub get -n /concourse/pa/cloudflare_key -j | jq .value)"" >> ./cloudflare.ini

echo "There will be a warning on the next run - but you can ignore it, because I delete the file after"

# Create or update the certificate
sudo certbot certonly --dns-cloudflare \
                      --dns-cloudflare-propagation-seconds 60  \
                      --dns-cloudflare-credentials ./cloudflare.ini \
                      --preferred-challenges dns-01 \
                      -d $2.$1.$3 \
                      -d *.apps.$2.$1.$3 \
                      -d *.sys.$2.$1.$3 \
                      -d opsmanager.$2.$1.$3 \
                      -d *.pks.$2.$1.$3 \
                      --agree-tos \
                      -m "$(credhub get -n /concourse/pa/email -j | jq .value)" \
                      --cert-path ./

echo "Certs exist"


credhub delete -n /concourse/$2/acme_cert &>/dev/null
# Store the certificate bits in credhub
credhub set -n /concourse/$2/acme_cert \
            -t certificate \
            -c "$(sudo cat /etc/letsencrypt/live/$2.$1.$3/fullchain.pem)" \
            -p "$(sudo cat /etc/letsencrypt/live/$2.$1.$3/privkey.pem)"

echo "If there were no DNS timeout errors, the certs were created/updated."
echo "If there were timeouts, its okay to re-run this script multiple times, its idempotent"

# Delete the temporary cloudflare.ini file
rm ./cloudflare.ini

echo "Cleanup complete"

