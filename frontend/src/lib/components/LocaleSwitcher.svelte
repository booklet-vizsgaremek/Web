<script lang="ts">
	import { getLocale, locales, setLocale } from '$lib/paraglide/runtime';

	let {
		disabled = false,
		classes = 'border-0 bg-transparent disabled:pointer-events-none disabled:opacity-50'
	} = $props();

	let currentLocale = $state(getLocale());
</script>

{#key currentLocale}
	<select
		onchange={(e) => setLocale(e.currentTarget.value as (typeof locales)[number])}
		class={classes}
		{disabled}
	>
		{#each locales as locale}
			<option selected={locale === currentLocale}>{locale.toUpperCase()}</option>
		{/each}
	</select>
{/key}
