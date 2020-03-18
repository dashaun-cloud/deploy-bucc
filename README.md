# deploy-bucc

Some additional scripts, to make starting from zero a little easier.

Getting started:

```
git clone https://github.com/starkandwayne/bucc
cd bucc
git checkout v0.9.0
git submodule add https://github.com/dashaun-cloud/deploy-bucc
```

If you plan to use the platform-automation-* repositories as well there are some additional dependencies:

```
sudo apt install jq -y
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt install certbot python3-certbot-dns-cloudflare -y
```
A couple of dependencies do not have an apt repository

YTT (part of k14s) https://github.com/k14s/ytt
```
curl -L https://k14s.io/install.sh | sudo bash
```

yaml-patch https://github.com/krishicks/yaml-patch/releases
Download it from the releases page and put it into your path

Docker is required to run Minio (remove old libs first)
```
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```

For GCP: bucc up --cpi gcp --concourse-lb
- Add a tag so we can create some firewall rules around it.  I've used "bucc" in the sample vars file.

```

- minio (for on-prem/vsphere - create cert, run as https)

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
