# deploy-bucc
- create a jumpbox
- Make sure to grab a release and not master from https://github.com/starkandwayne/bucc
- uncompress and mv to ~/bucc (or whatever)
- clone this repo
```
cp create_new_env.sh ~/bucc
cp credhub-vars.sh ~/bucc
```

# Additional Installations and Steps
- jq
```
apt install jq
```
- ytt - https://github.com/k14s/ytt
- certbot
```
apt update
apt install software-properties-common
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
apt install certbot python3-certbot-dns-cloudflare -y
```
- docker
- yaml-patch - https://github.com/krishicks/yaml-patch/releases
- minio (for on-prem/vsphere - create cert, run as https)
```
certbot certonly --dns-cloudflare \
  --dns-cloudflare-propagation-seconds 60  \
  --dns-cloudflare-credentials ./cloudflare.ini \
  --preferred-challenges dns-01 \
  -d minio.domain \
  --agree-tos \
  -m email

docker run -p 443:443 --name minio1 -e "MINIO_ACCESS_KEY=key" -e "MINIO_SECRET_KEY=password" -d -v /home/snoyes/.minio:/root/.minio/ -v /mnt/data:/data minio/minio server --address ":443" /data
```
  - create 2 buckets (foundation-installations, platform-automation)

# Finalize
Once bucc has configured the bosh/concourse vm:
- add default creds to credhub unless they exist (edit credhub-vars.sh and fill in relevant info while commenting or deleting IaaS blocks)
- create environment (./create_new_env.sh vsphere homelab dashaun.cloud)
- Login in to concourse (bucc info to get password) 
- add target to fly (fly --target example login --team-name my-team --concourse-url https://ci.example.com --insecure)
- create team in concourse (fly -t example set-team --team-name my-team --local-user foo)
- fly pipelines!
