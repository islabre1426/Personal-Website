---
title: acme.sh
---

My [ACME](https://en.wikipedia.org/wiki/Automatic_Certificate_Management_Environment) client of choice, since it supports Porkbun.

## Issuing a certificate
Using this website's domain as example. Also issuing a wildcard certificate for later use.

```
# export PORKBUN_API_KEY="<API key>"
# export PORKBUN_SECRET_API_KEY="<API secret key>"

# acme.sh --register-account -m "<your email>"
# acme.sh --issue --dns dns_porkbun -d islabre.fyi -d "*.islabre.fyi"
```

## Installing certificate to web server
Make sure you've included your SSL certificate path in your web server configuration before executing below commands, otherwise `acme.sh` will fail to restart the server.

Also, make sure you created the folder for these keys.

```
# acme.sh --install-cert -d islabre.fyi \
    --fullchain-file /etc/nginx/ssl/islabre.fyi/cert.pem \
    --key-file /etc/nginx/ssl/islabre.fyi/key.pem \
    --reloadcmd "service nginx force-reload"
```

## Installing cron job for auto-renewal
Needed when using `acme.sh` provided by the distribution's package manager (`apt` in this case).

```
# crontab -l # Check for existing acme.sh job
# acme.sh --install-cronjob
```