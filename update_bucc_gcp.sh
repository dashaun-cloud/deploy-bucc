#These are changes to the bosh-deployment that I needed to make in order to do platform automation using
#the pipelines at https://github.com/dashaun-cloud/platform-automation-pipelines

sed -i 's/machine_type: n1-standard-1/machine_type: n1-standard-4/g' src/bosh-deployment/gcp/cpi.yml
sed -i 's/root_disk_size_gb: 40/root_disk_size_gb: 400/g' src/bosh-deployment/gcp/cpi.yml
sed -i 's/root_disk_type: pd-standard/root_disk_type: pd-ssd/g' src/bosh-deployment/gcp/cpi.yml
