import adapter from '@sveltejs/adapter-static';
import preprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://github.com/sveltejs/svelte-preprocess
	// for more information about preprocessors
	preprocess: [
		preprocess({
			postcss: true
		})
	],

	kit: {
		// Self-hosted behind nginx instead of Cloudflare Pages: the whole site
		// is one prerendered page plus the static/ image library, and the
		// /gif/<code> API is an nginx rewrite (nginx/default.conf). This
		// SvelteKit vintage prerenders every non-dynamic route from
		// `prerender.entries = ['*']`, so no per-page opt-in is needed.
		adapter: adapter({
			pages: 'build',
			assets: 'build',
			fallback: null
		}),
		// The /gif/<code> links on the index page are nginx routes, not
		// SvelteKit ones — crawling them would 404 the build.
		prerender: {
			crawl: false
		},

		// hydrate the <div id="svelte"> element in src/app.html
		target: '#svelte'
	}
};

export default config;
