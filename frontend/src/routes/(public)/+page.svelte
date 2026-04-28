<script>
	import * as m from '$lib/paraglide/messages.js';
	import BookCarousel from '$lib/components/BookCarousel.svelte';
	import Autoplay from 'embla-carousel-autoplay';
	import * as Carousel from '$lib/components/ui/carousel/index.js';
	import { page } from '$app/state';
	import Checkbox from '$lib/components/ui/checkbox/checkbox.svelte';
	import Label from '$lib/components/ui/label/label.svelte';

	const plugin = Autoplay({ delay: 5000, stopOnInteraction: true });
	let autoplayEnabled = $state(true);

	$effect(() => {
		if (!autoplayEnabled) plugin.stop();
		else plugin.play();
	});

	const { data } = $props();
</script>

<div
	class="mx-auto flex min-h-screen w-full flex-col gap-24 px-4 pt-16! pb-12 md:w-4/5 md:px-0 md:pb-24"
>
	{#if page.data.discounts.length}
		<div>
			<Carousel.Root plugins={[plugin]} opts={{ loop: true }} class="relative mx-auto w-full">
				<Carousel.Content>
					{#each page.data.discounts as discount}
						<Carousel.Item>
							{#if discount.book}
								<a
									class="flex h-full w-full flex-col items-center justify-center gap-4 bg-blue-950 px-16 py-4 text-white md:items-start"
									href="/books/{discount.book.id}"
								>
									<h1 class="text-lg md:text-xl">{m['home.discounts.book.title']()}</h1>
									<p class="text-xs md:text-sm">
										{m['home.discounts.book.description']({
											title: discount.book.title,
											discount: discount.discount
										})}
									</p>
								</a>
							{/if}
							{#if discount.genre}
								<a
									class="flex h-full w-full flex-col items-center justify-center gap-4 bg-amber-300/75 px-16 py-4 text-black md:items-start"
									href="/books?genre={discount.genre.id}"
								>
									<h1 class="text-lg md:text-xl">{m['home.discounts.genre.title']()}</h1>
									<p class="text-xs md:text-sm">
										{m['home.discounts.genre.description']({
											name_en: discount.genre.name_en,
											name_hu: discount.genre.name_hu,
											discount: discount.discount
										})}
									</p>
								</a>
							{/if}
						</Carousel.Item>
					{/each}
				</Carousel.Content>
				<Carousel.Previous class="absolute top-1/2 left-2 z-10 -translate-y-1/2 rounded-none" />
				<Carousel.Next class="absolute top-1/2 right-2 z-10 -translate-y-1/2 rounded-none" />
			</Carousel.Root>
			<Label class="mt-8 flex cursor-pointer items-center gap-2">
				<Checkbox class="rounded-none" bind:checked={autoplayEnabled} />
				{m['home.discounts.animation']()}
			</Label>
		</div>
	{/if}
	{#if data.topPurchased.length}
		<section class="flex h-max w-full flex-col items-center gap-12 md:items-start">
			<h1 class="text-3xl">{m['home.top_10']()}</h1>
			<BookCarousel books={data.topPurchased} topList={true} discounts={data.discounts} />
		</section>
	{/if}
	{#if data.randomCategory.length}
		<section class="flex h-max w-full flex-col items-center gap-12 md:items-start">
			<h1 class="text-3xl">{m['home.random_category']()}</h1>
			<BookCarousel books={data.randomCategory} discounts={data.discounts} />
		</section>
	{/if}
	{#if data.discounted.length}
		<section class="flex h-max w-full flex-col items-center gap-12 md:items-start">
			<h1 class="text-3xl">{m['home.discounted']()}</h1>
			<BookCarousel books={data.discounted} discounts={data.discounts} />
		</section>
	{/if}
	{#if !data.topPurchased.length && !data.randomCategory.length && !data.discounted.length}
		<h1 class="text-2xl">{m['home.no_data']()}</h1>
	{/if}
</div>
