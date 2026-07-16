---
title: Simple tech, simple way, simple life
date: 2026-07-16T17:44:40+07:00
---

I like simple tech and simple way of doing things. If a job requires multiple steps with complicated technology, I won't be willing to do it.

## Server
For example, I want a way to visualize web server log. I looked at solution like Prometheus and Grafana, and I was like "nah not gonna do this".

...until I saw [GoAccess](https://goaccess.io/).

I was like "view web server log directly in the terminal? That looks so cool!"

What I needed to do is:
```
sudo apt install goaccess
sudo goaccess /var/log/caddy/personal-website.access.log --log-format CADDY
```

That's it. No further setup needed. And it does what I wanted: a way to view web server log visually.

Wanting to keep the dashboard running? Attach a `tmux` session and run `goaccess` inside it.

Simple.

Other piece of tech I started using is Caddy. I wanted to have automatic HTTPS without having to deal with `certbot` and simple configuration syntax.

At first, I hesitate from using it due to it not having rate-limiting feature. It is provided as a 3rd-party module and I need to use `xcaddy` to compile it.

Well, on the bright side, it provides simple way to configure wildcard certificate for Porkbun.

My `Caddyfile` is just like this:
```
{
    acme_dns porkbun {
        api_key {env.PORKBUN_API_KEY}
        api_secret_key {env.PORKBUN_API_SECRET_KEY}
    }
}

(rate_limit) {
    rate_limit {
        zone static {
            match {
                method GET HEAD POST
            }

            key static
            events 10
            window 1s
        }

        log_key
    }
}

islabre.fyi {
    root /srv/Personal-Website
    file_server

    log {
        output file /var/log/caddy/personal-website.access.log
    }

    import rate_limit
}
```

Also, no more Anubis. I should utilize normal firewall like `ufw` instead.

Keep it simple.

## Website
This website looks simple and barebone. It's my choice. This UI style is applied to many projects I started.

Why? Because it's lightweight and fast. And I don't have to debug my UI often.

If you don't like it, it's fine. I'm not here to please you.

I'm capable of making pretty UI if I'm willing to. I decided to stay simple instead.

## Why?
Why stay simple? Why be "boring"? Why?

Because complexity costs everything, from money to my sanity.

And by staying simple, I can be more flexible.

Maybe this resonate with you.

See you.