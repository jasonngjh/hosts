# hosts

A small, hand-curated blocklist of advertising and tracking domains, in hosts
format for Pi-hole (or any DNS sinkhole).

Not a mega-list. Every domain here was seen serving ads in a live page capture
and was checked not to break the page content when blocked.

## Files

- `domains.txt` — source of truth, one domain per line. Edit this.
- `hosts` — generated. `0.0.0.0 domain` lines for Pi-hole / `/etc/hosts`.
- `build.sh` — regenerates `hosts` from `domains.txt` (`./build.sh`).

Pi-hole matches subdomains of a blocked domain, so only registrable domains are
listed — blocking `magsrv.com` also covers `a.magsrv.com` and `s.magsrv.com`.

## Usage

**Pi-hole (recommended)** — Settings → Lists → Add:

```
https://raw.githubusercontent.com/jasonngjh/hosts/main/hosts
```

**Manually** — merge `hosts` into your Pi-hole's blocklist, or:

```sh
curl -sL <raw-url> | sudo tee -a /etc/pihole/hosts-extra
```

> This repo is private, so Pi-hole cannot fetch the URL without credentials.
> Either make the repo public (nothing here is a secret), or paste the contents
> of `hosts` into Settings → Domains → Deny.

## Updating

Edit `domains.txt`, run `./build.sh`, commit both files.

Ad networks rotate hostnames (Clickadu especially). Keep the network root
domains — they catch most of the churn — and re-scan when ads reappear.

## Scope

DNS blocking kills ad requests, popunder scripts and tracking beacons. It cannot
remove creatives that a site serves from its own domain, and it does no cosmetic
filtering — use uBlock Origin alongside if you want those gone.
