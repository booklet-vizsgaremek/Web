<script lang="ts">
	import { getLocale } from '$lib/paraglide/runtime';
	import useDarkMode from '$lib/stores/darkMode.svelte';
	import { fade } from 'svelte/transition';

	const dark = useDarkMode();

	let logoPromise = $derived(
		import(`$lib/assets/logos/logo_${getLocale()}_${dark.darkMode ? 'white' : 'black'}.svg?url`)
	);
</script>

{#await logoPromise}
	<div class="mb-6 h-12 w-32! animate-pulse bg-background"></div>
{:then logo}
	<img transition:fade={{ delay: 100 }} id="logo" class="mb-6 h-12" src={logo.default} alt="Logo" />
{/await}
