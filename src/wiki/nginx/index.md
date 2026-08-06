---
title: nginx
---

My web server of choice.

## Installation
```
# apt install nginx
```

## Block undefined domain
```
# /etc/nginx/conf.d/undefined.conf

server {
    listen 443 ssl default_server;
    ssl_reject_handshake on;
    return 444;
}
```

## Serving website
The following uses this website configuration as example.

```
# /etc/nginx/conf.d/personal-website.conf

server {
    listen 443 ssl;
    server_name islabre.fyi;
    root /var/www/html/Personal-Website;

    limit_req zone=perip burst=5;
    limit_req zone=perserver burst=10;

    expires 1d;
    add_header Cache-Control must-revalidate;

    ssl_certificate /etc/ssl/certs/islabre.fyi/cert.pem;
    ssl_certificate_key /etc/ssl/certs/islabre.fyi/key.pem;

    location / {

    }
}
```

Note:
- The empty `location / {}` block is needed to stop path traversal attack
- It's benefical to cache pages to speed up UX (1 day cache seems to be enough)

## Rate-limiting
Essential for slowing down bots.

```
# /etc/nginx/conf.d/rate-limiting.conf

limit_req_zone $binary_remote_addr zone=perip:10m rate=5r/s;
limit_req_zone $server_name zone=perserver:10m rate=15r/s;
```