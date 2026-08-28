# http-vadivelu — SvelteKit prerendered at build time, nginx serves the result.
#
# The app is frozen in early 2022 (@sveltejs/kit 1.0.0-next.214, svelte 3.44,
# pnpm lockfile 5.3), so the builder is deliberately node 16 + pnpm 6: the
# versions that lockfile was written for. Every devDependency is pinned to an
# exact version — `next`-tagged specs would resolve to SvelteKit 3.x today and
# nothing would build.
#
# There is no server side: adapter-static prerenders the single page and nginx
# does the /gif/200 → /gif/200.gif mapping (see nginx/default.conf).
FROM node:16-alpine@sha256:a1f9d027912b58a7c75be7716c97cfbc6d3099f3a97ed84aa490be9dee20e787 AS build

WORKDIR /app
RUN npm install -g pnpm@6.32.15

COPY .npmrc package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm run build

FROM nginx:1.29-alpine@sha256:5616878291a2eed594aee8db4dade5878cf7edcb475e59193904b198d9b830de

COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
