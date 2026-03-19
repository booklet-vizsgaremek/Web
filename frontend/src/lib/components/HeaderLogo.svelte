<script lang="ts">
	import { getLocale } from '$lib/paraglide/runtime';
	import useDarkMode from '$lib/stores/darkMode.svelte';

	let { isMobile } = $props();
	const dark = useDarkMode();

	let logoPromise = $derived(
		import(
			`$lib/assets/logos/${isMobile ? 'logo_minimal' : `logo_${getLocale()}`}_${dark.darkMode ? 'white' : 'black'}.svg?url`
		)
	);
</script>

{#await logoPromise}
	<div class="aspect-square h-8/12 animate-pulse bg-background md:aspect-auto md:w-36"></div>
{:then logo}
	<img id="logo" alt="Logo" src={logo.default} />
{/await}
