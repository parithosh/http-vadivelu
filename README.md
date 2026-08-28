# On demand HTTP Codes with images

🚶‍♂️🔨HTTP Vadivelu Status codes

![intro](https://github.com/anoram/http-vadivelu/blob/master/static/intro.jpg)

This is the sveltekit version of the repo, the old repo is [here](https://github.com/anoram/http-vadivelu-legacy)

# This fork

Self-hosted at https://vadivelu.indenwolken.xyz — same app, no Cloudflare
Pages, no origin fetches:

- `@sveltejs/adapter-static` instead of `adapter-cloudflare`: the single page
  is prerendered at build time.
- `nginx/default.conf` implements the extension-less API (`/gif/200`,
  `/jpg/404`) the upstream README credits to its Apache config. GIF first,
  then the JPG of the same code. That replaces `src/routes/[...slug].ts`,
  which proxied every request back to `vadivelu.anoram.com` — a hard
  dependency on the upstream deployment.
- `Dockerfile`: node 16 + pnpm 6 build (the versions `pnpm-lock.yaml` was
  written for) → nginx. Every devDependency is pinned exactly; the original
  `next`-tagged SvelteKit specs resolve to 3.x today and do not build.
- `.github/workflows/docker.yml` publishes
  `ghcr.io/parithosh/http-vadivelu` (linux/amd64) on every push to `master`.

Build and run it locally:

```sh
docker build -t http-vadivelu .
docker run --rm -p 8080:80 http-vadivelu
curl -sI localhost:8080/gif/200
```

# Usage

example https://vadivelu.anoram.com/gif/200
*Some don't have JPGs. Consider contributing.
*API prioritizes GIFs if you need just the jpg version use \*https://vadivelu.anoram.com/jpg/200

# About

This is a fan project by Anoram and is hosted at https://vadivelu.anoram.com.
This does not require any server side code, API works because of the behaviour of our Apache config.
The idea came from https://twitter.com/coderice1/status/1269259097456566272?s=21

# Suggestions and other status code addition

- Please create an issue with what you would like to add.
- We are aware that several codes are missing, help us :)

# License

MIT
