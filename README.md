# deploy-bucc

This is a helper project for the 'platform-automation-*' repositories.

It provides some additional scripts and conventions, to make starting from zero a little easier.

## Getting started:

This assumes you have a "jumpbox" created that can communicate with your IAAS.

This assumes the jumpbox is Ubuntu 18.04 | 19.04 | 19.10 | 20.04

The following steps will be executed on that jumpbox.

### Checkout BUCC and the 'deploy-bucc' submodule  

```
git clone https://github.com/starkandwayne/bucc
cd bucc
git checkout v0.9.0
git submodule add https://github.com/dashaun-cloud/deploy-bucc
```

### Deploy BUCC

On GCP:
```
bucc up --cpi gcp --concourse-lb
```
Edit the vars.yml, use samples/gcp.sample.vars.yml for guidance.

This step takes a while:
```
bucc up
```

Install the credhub CLI:
```
bucc credhub
```

### Add some secrets

This script expects some secrets to be provided as environment variables.

You checked out bucc, and this submodule already above.

```
cp deploy-bucc/samples/.envrc.sample deploy-bucc/.envrc
```

Populate this new .envrc file with your secrets.

Now put those values into the current environment:


Option 1: With direnv installed:
```
cd deploy-bucc
direnv allow
./credhub-vars.sh
```

Option 2: Without direnv:
```
cd deploy-bucc
source .envrc
./credhub-vars.sh
```

You now have some of your secrets stored in CredHub.


```
rm .envrc
```

### Create a new CredHub path with values for platform automation

This step will use values you provided above, to create a new path of values.

Additionally, it will generate some secrets, generate some certificates.

Your jumpbox needs a couple of dependencies for this task

```
sudo apt install jq -y
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt install certbot python3-certbot-dns-cloudflare -y
```
