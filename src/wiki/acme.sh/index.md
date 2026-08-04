---
title: acme.sh
---

My [ACME](https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment) client of choice, since it supports [Porkbun](https://porkbun.com/).

## Installation
```
# apt install acme.sh
```

## Issuing certificate
Using this website's domain as example. Also issuing wildcard certificate for subdomain use.

```
# export PORKBUN_API_KEY="<API key>"
# export PORKBUN_SECRET_API_KEY="<API secret key>"
# acme.sh --register-account -m "<your email>"
# acme.sh --issue --dns dns_porkbun -d islabre.fyi -d "*.islabre.fyi"
```

## Installing certificate
Any services that is included in `--reloadcmd` need to be configured with the SSL path before invoking below commands.

```
# mkdir -p /etc/ssl/certs/islabre.fyi
# acme.sh --install-cert -d islabre.fyi \
    --fullchain-file /etc/ssl/certs/islabre.fyi/cert.pem \
    --key-file /etc/ssl/certs/islabre.fyi/key.pem \
    --reloadcmd "systemctl restart nginx coturn"
```

## Installing cron job for auto-renewal
Needed when using `acme.sh` provided by the distribution's package manager (`apt` in this case).

```
# crontab -l # Check for existing acme.sh job
# acme.sh --install-cronjob
```