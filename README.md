# deploy-bucc

Make sure to grab a release and not master from https://github.com/starkandwayne/bucc

For GCP: bucc up --cpi gcp --concourse-lb
- Add a tag so we can create some firewall rules around it.  I've used "bucc" in the sample vars file.

Additional installation:
- jq
- yyt
- certbot
- docker
- yaml-patch
- minio (for on-prem - create cert, run as https)
	sudo certbot certonly --dns-cloudflare \
       --dns-cloudflare-propagation-seconds 60  \
       --dns-cloudflare-credentials ./cloudflare.ini \
       --preferred-challenges dns-01 \
       -d <minio.domain> \
       --agree-tos \
       -m <email>
    sudo docker run -p 443:443 --name minio1 -e "MINIO_ACCESS_KEY=<key>" -e "MINIO_SECRET_KEY=<password>" -d -v /home/snoyes/.minio:/root/.minio/ -v /mnt/data:/data minio/minio server --address ":443" /data
    - create 2 buckets (foundation-installations, platform-automation)

Once bucc has configured the bosh/concourse vm:
- add default creds to credhub unless they exist (./credhub-vars.sh)
- create environment (./create_new_env.sh gcp new_gcp_environment_name dashaun.cloud)
- Login in to concourse (bucc info to get password) 
- add target to fly (fly --target example login --team-name my-team --concourse-url https://ci.example.com --insecure)
- create team in concourse (fly -t example set-team --team-name my-team --local-user foo)
- fly pipelines!
