---
title: Setting up this website with Nginx
date: 2026-07-10T17:46:45+07:00
---

This is a little tutorial on setting up Nginx to serve this website.

At first, I went with Coolify since it provides me ease of deployment. Later I decided to wipe the server and start over since the tech stack is too complex for my taste, and I want to learn how to set it up myself.

## Prerequisites
- A server that can be SSH'd to (I use Hetzner with Debian 13 installed)
- A domain (I registered one from Porkbun)
- SSL Certificate, so this website can be served over HTTPS (Porkbun provides this as a bundle after them setting up SSL for my domain)

## Setup
1. SSH to the server (make sure you set this up first):
    ```
    ssh personal-server
    ```

2. Update the server (if required, restart the server using `reboot` command):
    ```
    apt update && apt upgrade
    ```

3. Install nginx:
    ```
    apt install nginx
    ```

4. Enable nginx on startup:
    ```
    systemctl enable --now nginx
    ```

5. Add the following content to `/etc/nginx/conf.d/personal-website.conf`:
    ```
    server {
        listen 443 ssl;
        server_name islabre.fyi;
        ssl_certificate /etc/ssl/islabre.fyi-ssl-bundle/domain.cert.pem;
        ssl_certificate_key /etc/ssl/islabre.fyi-ssl-bundle/private.key.pem;

        location / {
            root /var/www/html/Personal-Website;
        }
    }
    ```

6. On the host, `rsync` both the website's build artifact and the SSL bundle to the server:
    ```
    cd /path/to/Personal-Website/
    npm run build
    rsync -av --delete _site/ root@personal-server:/var/www/html/Personal-Website/
    ```

    ```
    cd /path/to/folder/contain/islabre.fyi-ssl-bundle
    rsync -av --delete islabre.fyi-ssl-bundle/ root@personal-server:/etc/ssl/islabre.fyi-ssl-bundle/
    ```

7. On the server, restart nginx:
    ```
    systemctl restart nginx
    ```

8. Go to https://islabre.fyi. If the website shows up then you're done!