<script lang="ts">
	import Button from '$lib/components/ui/button/button.svelte';
	import getGreeting from '$lib/utils/greeting';
	import * as m from '$lib/paraglide/messages.js';
	import { goto } from '$app/navigation';
	import { page } from '$app/state';
</script>

<div class="mx-auto flex w-full flex-col gap-8 px-4 pt-16! pb-12 md:w-4/5 md:px-0 md:pb-24">
	<h1 class="text-3xl">{getGreeting(page.data.user?.first_name ?? null)}</h1>
	<h2 class="text-2xl">{m['management']()}</h2>
	<div class="flex flex-col gap-2 md:flex-row">
		{#if page.data.user?.role === 'admin'}
			<Button onclick={() => goto('/users')} class="cursor-pointer">
				{m['title.users']()}
			</Button>
		{/if}
		<Button onclick={() => goto('/staff/orders')} class="cursor-pointer">
			{m['title.orders']()}
		</Button>
		{#if page.data.user?.role === 'staff'}
			<Button onclick={() => goto('/books')} class="cursor-pointer">
				{m['title.book_lookup']()}
			</Button>
		{/if}
		{#if ['admin', 'manager'].includes(page.data.user?.role)}
			<Button onclick={() => goto('/coupons')} class="cursor-pointer">
				{m['title.coupons']()}
			</Button>
		{/if}
	</div>
	{#if ['admin', 'manager'].includes(page.data.user?.role)}
		<h2 class="text-2xl">{m['data_management']()}</h2>
		<div class="flex flex-col gap-2 md:flex-row">
			<Button onclick={() => goto('/books')} class="cursor-pointer">
				{m['title.books']()}
			</Button>
			<Button onclick={() => goto('/authors')} class="cursor-pointer">
				{m['title.authors']()}
			</Button>
			<Button onclick={() => goto('/genres')} class="cursor-pointer">
				{m['title.genres']()}
			</Button>
			<Button onclick={() => goto('/publishers')} class="cursor-pointer">
				{m['title.publishers']()}
			</Button>
		</div>
	{/if}
</div>
