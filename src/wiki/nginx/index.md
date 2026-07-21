---
title: nginx
---

My web server of choice.

## Serving website
The following uses this website configuration as example.

```
# /etc/nginx/conf.d/personal-website.conf

# For undefined domain
server {
    listen 443 ssl;
    ssl_reject_handshake on;
    return 444;
}

server {
    listen 443 ssl;
    server_name islabre.fyi;
    root /var/www/html/Personal-Website;

    limit_req zone=perip burst=5;
    limit_req zone=perserver burst=10;

    add_header Cache-Control no-cache;

    ssl_certificate /etc/ssl/certs/islabre.fyi/cert.pem;
    ssl_certificate_key /etc/ssl/certs/islabre.fyi/key.pem;

    location / {

    }
}
```

Note:
- The empty `location / {}` block is needed to stop path traversal attack
- This website does not version files, so it's benefical to revalidate server files each time using `Cache-Control: no-cache` header

## Rate-limiting
Essential for slowing down bots.

```
# /etc/nginx/conf.d/rate-limiting.conf

limit_req_zone $binary_remote_addr zone=perip:10m rate=1r/s;
limit_req_zone $server_name zone=perserver:10m rate=10r/s;
```