---
title: coturn
---

TURN server implementation. Currently used for [tempchat](https://codeberg.org/islabre1426/tempchat).

You can use my server as relay, with respect.
- URL: turn:turn.islabre.fyi:5349
- Username: webrtc-turn
- Password: webrtc-turn

## Installation
```
# apt install coturn
```

## Setup
```
# /etc/default/coturn

# Allow coturn to be started as system service
TURNSERVER_ENABLED=1
```

```
# /etc/turnserver.conf

realm=islabre.fyi
server-name=turn.islabre.fyi

listening-ip=0.0.0.0
external-ip=<your server IP>

# Logging behavior
fingerprint
log-file=/var/log/turnserver.log
verbose

# SSL
cert=/etc/ssl/certs/islabre.fyi/cert.pem
pkey=/etc/ssl/certs/islabre.fyi/key.pem
tls-listening-port=5349

# Auth for TURN
lt-cred-mech
user=webrtc-turn:webrtc-turn

# Default configuration
syslog
no-rfc5780
no-stun-backward-compatibility
response-origin-only-with-rfc5780
```

## Apply configuration
```
# systemctl restart coturn.service
```

And test endpoint `turn:turn.islabre.fyi:5349` via free TURN server tester on the internet.