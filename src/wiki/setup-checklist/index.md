---
title: Setup Checklist
---

If you setup a new server for the first time for serving web content, this is a checklist for what to do.

## Prerequisite
- A server with an OS installed (I use Hetzner Cloud with Debian)
- A domain (I use Porkbun)
- Basic Linux terminal knowledge (e.g. how to SSH to the server)

## Setup
- [ ] Update the system
    ```
    # apt update && apt upgrade
    ```
- [ ] Install a firewall
    ```
    # apt install ufw
    ```
- [ ] Setup firewall:
    - [ ] Default: deny incoming, allow outgoing (default configuration for `ufw`)
    - [ ] Allow: port 443 (HTTPS)
    - [ ] Limit: port 22 (SSH, to help with brute-force attack)
    ```
    # ufw allow https
    # ufw limit ssh
    ```
- [ ] Enable firewall
- [ ] Install web server, log analyzer, and ACME client (for SSL)
    ```
    # apt install nginx goaccess acme.sh
    ```
- [ ] Configure nginx [via this entry](../nginx/)
- [ ] Setup SSL certificate using your ACME client ([see this entry for acme.sh example](../acme.sh/))
- [ ] Deploy your web content to the server