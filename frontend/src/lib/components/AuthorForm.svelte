<script lang="ts">
	import * as m from '$lib/paraglide/messages.js';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Textarea } from '$lib/components/ui/textarea';
	import { ChevronLeft } from '@lucide/svelte';
	import { superForm } from 'sveltekit-superforms';
	import * as Form from '$lib/components/ui/form';
	import type { Author } from '$lib/types';
	import { page } from '$app/state';
	import { goto } from '$app/navigation';
	import { toast } from 'svelte-sonner';
	import Spinner from './ui/spinner/spinner.svelte';

	const {
		data
	}: {
		data: { author?: Author; form: any };
	} = $props();

	// svelte-ignore state_referenced_locally
	const form = superForm(data.form, {
		resetForm: false,
		onUpdated({ form }) {
			if (form.valid) {
				if (page.url.pathname.startsWith('/authors/new')) {
					toast.success(m['messages.successful_author_save']());
					goto(`/authors/${form.message?.id}/edit`);
				} else {
					toast.success(m['messages.successful_author_save']());
				}
			} else {
				toast.error(form.message?.error ?? m['messages.server_error']());
			}
		}
	});
	const { form: formData, enhance, submitting } = form;
</script>

<div class="mx-auto w-full px-4 pt-16! pb-12 md:w-4/5 md:px-0 md:pb-24">
	<Button
		variant="link"
		class="mb-8 cursor-pointer hover:no-underline md:-ml-12"
		onclick={() => history.back()}
	>
		<ChevronLeft />
		{m['navigation.back']()}
	</Button>
	{#if page.url.pathname.startsWith('/authors/new')}
		<h1 class="mb-10 text-3xl">{m['title.new_author']()}</h1>
	{/if}
	<form method="POST" use:enhance>
		<div class="flex flex-col gap-6 md:w-1/3">
			<Form.Field {form} name="name">
				<Form.Control>
					{#snippet children({ props })}
						<Form.Label>{m['admin.author.name']()}</Form.Label>
						<Input {...props} bind:value={$formData.name} />
					{/snippet}
				</Form.Control>
				<Form.FieldErrors />
			</Form.Field>
			<Form.Field {form} name="biography_en">
				<Form.Control>
					{#snippet children({ props })}
						<Form.Label>{m['admin.author.biography_en']()}</Form.Label>
						<Textarea {...props} rows={6} bind:value={$formData.biography_en} />
					{/snippet}
				</Form.Control>
				<Form.FieldErrors />
			</Form.Field>
			<Form.Field {form} name="biography_hu">
				<Form.Control>
					{#snippet children({ props })}
						<Form.Label>{m['admin.author.biography_hu']()}</Form.Label>
						<Textarea {...props} rows={6} bind:value={$formData.biography_hu} />
					{/snippet}
				</Form.Control>
				<Form.FieldErrors />
			</Form.Field>
			<div class="flex gap-3 pt-2">
				<Button type="submit" class="flex cursor-pointer items-center gap-2" disabled={$submitting}>
					{#if $submitting}
						<Spinner />
					{:else if page.url.pathname.startsWith('/authors/new')}
						{m['actions.create']()}
					{:else}
						{m['actions.save']()}
					{/if}
				</Button>
			</div>
		</div>
	</form>
</div>
