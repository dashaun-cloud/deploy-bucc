# deploy-bucc

Some additional scripts, to make starting from zero a little easier.

Getting started:

Make sure to grab a release and not master from https://github.com/starkandwayne/bucc

```
git clone https://github.com/starkandwayne/bucc
cd bucc
git checkout v0.9.0
git submodule add https://github.com/dashaun-cloud/deploy-bucc
```

For GCP: bucc up --cpi gcp --concourse-lb
- Add a tag so we can create some firewall rules around it.  I've used "bucc" in the sample vars file.

Additional installation:
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

Once bucc has configured the bosh/concourse vm:
- add default creds to credhub unless they exist (./credhub-vars.sh)
- create environment (./create_new_env.sh gcp new_gcp_environment_name dashaun.cloud)
- Login in to concourse (bucc info to get password) 
- add target to fly (fly --target example login --team-name my-team --concourse-url https://ci.example.com --insecure)
- create team in concourse (fly -t example set-team --team-name my-team --local-user foo)
- fly pipelines!
