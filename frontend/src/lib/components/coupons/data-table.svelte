<script lang="ts">
	import * as m from '$lib/paraglide/messages.js';
	import * as Table from '$lib/components/ui/table/index.js';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import * as Accordion from '$lib/components/ui/accordion/index.js';
	import * as Select from '$lib/components/ui/select/index.js';
	import * as Form from '$lib/components/ui/form';
	import * as Pagination from '$lib/components/ui/pagination/';
	import { Input } from '$lib/components/ui/input/index.js';
	import Button from '$lib/components/ui/button/button.svelte';
	import { toast } from 'svelte-sonner';
	import { enhance } from '$app/forms';
	import { goto } from '$app/navigation';
	import { page } from '$app/state';
	import {
		type ColumnFiltersState,
		type PaginationState,
		type SortingState,
		type VisibilityState,
		getCoreRowModel,
		getFilteredRowModel,
		getPaginationRowModel,
		getSortedRowModel
	} from '@tanstack/table-core';
	import { FlexRender, createSvelteTable } from '$lib/components/ui/data-table/index.js';
	import type { Book, Coupon, Genre, User } from '$lib/types';
	import { columns } from './columns.js';
	import { Pencil, Plus, Trash } from '@lucide/svelte';
	import Spinner from '$lib/components/ui/spinner/spinner.svelte';
	import { superForm } from 'sveltekit-superforms';
	import ComboSelect from '$lib/components/ComboSelect.svelte';
	import { getLocale } from '$lib/paraglide/runtime.js';
	import Separator from '../ui/separator/separator.svelte';

	const FILTER_KEYS = [
		'scope',
		'has_user',
		'starts_after',
		'starts_before',
		'ends_after',
		'ends_before'
	] as const;
	type FilterKey = (typeof FILTER_KEYS)[number];

	type DataTableProps = {
		data: Coupon[];
		meta: { per_page: number; total: number; current_page: number };
		books: Book[];
		genres: Genre[];
		users: User[];
		form: any;
	};

	let { data, meta, books, genres, users, form: formProp }: DataTableProps = $props();

	let filters = $state<Record<FilterKey, string>>(
		Object.fromEntries(FILTER_KEYS.map((k) => [k, page.url.searchParams.get(k) ?? ''])) as Record<
			FilterKey,
			string
		>
	);
	let currentPage = $state(Number(page.url.searchParams.get('page') ?? 1));

	function applyFilters() {
		currentPage = 1;
		const params = new URLSearchParams({ page: '1' });
		for (const key of FILTER_KEYS) {
			if (filters[key]) params.set(key, filters[key]);
		}
		goto(`?${params}`, { keepFocus: true });
	}

	function clearFilters() {
		currentPage = 1;
		for (const key of FILTER_KEYS) filters[key] = '';
		goto('?', { keepFocus: true });
	}

	// svelte-ignore state_referenced_locally
	const form = superForm(formProp, {
		resetForm: true,
		onSubmit({ formData: fd }) {
			if (formTarget !== true && formTarget !== null) fd.append('id', formTarget.id);
			if (!fd.get('book_id')) fd.set('book_id', '');
			if (!fd.get('genre_id')) fd.set('genre_id', '');
			if (!fd.get('user_id')) fd.set('user_id', '');
			if (!fd.get('code')) fd.set('code', '');
		},
		onUpdated({ form }) {
			if (form.valid) {
				toast.success(
					formTarget === true
						? m['admin.coupon.action.create_success']()
						: m['admin.coupon.action.edit_success']()
				);
				formTarget = null;
			} else {
				toast.error(m['messages.server_error']());
			}
		}
	});

	const { form: formData, enhance: formEnhance, submitting } = form;

	let deleteTarget = $state<Coupon | null>(null);
	let deleting = $state(false);
	let formTarget = $state<Coupon | true | null>(null);
	let formType = $state<'coupon' | 'discount'>('coupon');
	let scopeType = $state<'book' | 'genre'>('book');

	const bookItems = $derived(books.map((b) => ({ id: b.id, label: b.title })));
	const genreItems = $derived(
		genres.map((g) => ({ id: g.id, label: getLocale() === 'hu' ? g.name_hu : g.name_en }))
	);
	const userItems = $derived(
		users.map((u) => ({
			id: u.id,
			label: `${getLocale() === 'hu' ? `${u.last_name} ${u.first_name}` : `${u.first_name} ${u.last_name}`} (${u.email})`
		}))
	);

	function openCreate() {
		formTarget = true;
		$formData.book_id = null;
		$formData.genre_id = null;
		$formData.user_id = null;
		$formData.discount = 0;
		$formData.starts_at = '';
		$formData.ends_at = '';
		$formData.code = null;
		formType = 'coupon';
		scopeType = 'book';
	}

	function openEdit(coupon: Coupon) {
		formTarget = coupon;
		$formData.book_id = coupon.book_id;
		$formData.genre_id = coupon.genre_id;
		$formData.user_id = coupon.user_id;
		$formData.discount = coupon.discount;
		$formData.starts_at = coupon.starts_at ? coupon.starts_at.slice(0, 10) : '';
		$formData.ends_at = coupon.ends_at ? coupon.ends_at.slice(0, 10) : '';
		$formData.code = coupon.code;
		formType = coupon.book_id || coupon.genre_id ? 'coupon' : 'discount';
		scopeType = coupon.book_id ? 'book' : 'genre';
	}

	const cols = columns(
		(coupon) => (deleteTarget = coupon),
		(coupon) => openEdit(coupon)
	);

	let pagination = $state<PaginationState>({ pageIndex: 0, pageSize: 10 });
	let sorting = $state<SortingState>([]);
	let columnFilters = $state<ColumnFiltersState>([]);
	let columnVisibility = $state<VisibilityState>({});

	const table = createSvelteTable({
		get data() {
			return data;
		},
		columns: cols,
		state: {
			get pagination() {
				return pagination;
			},
			get sorting() {
				return sorting;
			},
			get columnFilters() {
				return columnFilters;
			},
			get columnVisibility() {
				return columnVisibility;
			}
		},
		manualPagination: true,
		getCoreRowModel: getCoreRowModel(),
		getPaginationRowModel: getPaginationRowModel(),
		getSortedRowModel: getSortedRowModel(),
		getFilteredRowModel: getFilteredRowModel(),
		onPaginationChange: (u) => {
			pagination = typeof u === 'function' ? u(pagination) : u;
		},
		onSortingChange: (u) => {
			sorting = typeof u === 'function' ? u(sorting) : u;
		},
		onColumnFiltersChange: (u) => {
			columnFilters = typeof u === 'function' ? u(columnFilters) : u;
		},
		onColumnVisibilityChange: (u) => {
			columnVisibility = typeof u === 'function' ? u(columnVisibility) : u;
		}
	});
</script>

<div class="mx-auto w-full px-4 pt-16 md:w-4/5 md:px-0">
	<h1 class="mb-6 text-3xl">{m['title.coupons']()}</h1>
	<div class="mb-6 flex flex-col gap-2">
		<Accordion.Root type="single">
			<Accordion.Item value="filters" class="border-t-0">
				<Accordion.Trigger class="py-1 text-sm text-muted-foreground hover:no-underline">
					{m['admin.coupon.filter.label']()}
				</Accordion.Trigger>
				<Accordion.Content>
					<div class="flex flex-col gap-4 pt-2 pb-1">
						<div class="flex flex-col gap-2 md:flex-row">
							{#each [{ key: 'scope' as FilterKey, label: m['admin.coupon.filter.scope'](), options: [{ value: '', label: m['admin.coupon.filter.all']() }, { value: 'book', label: m['admin.coupon.scope_book']() }, { value: 'genre', label: m['admin.coupon.scope_genre']() }] }, { key: 'has_user' as FilterKey, label: m['admin.coupon.user'](), options: [{ value: '', label: m['admin.coupon.filter.all']() }, { value: 'yes', label: m['admin.coupon.filter.has_user']() }, { value: 'no', label: m['admin.coupon.filter.no_user']() }] }] as f}
								<div class="flex flex-1 flex-col gap-1">
									<span class="text-xs text-muted-foreground">{f.label}</span>
									<Select.Root
										type="single"
										value={filters[f.key]}
										onValueChange={(v) => (filters[f.key] = v ?? '')}
									>
										<Select.Trigger class="w-full cursor-pointer">
											{f.options.find((o) => o.value === filters[f.key])?.label ??
												f.options[0].label}
										</Select.Trigger>
										<Select.Portal>
											<Select.Content>
												{#each f.options as opt}
													<Select.Item value={opt.value} class="cursor-pointer"
														>{opt.label}</Select.Item
													>
												{/each}
											</Select.Content>
										</Select.Portal>
									</Select.Root>
								</div>
							{/each}
						</div>
						<div class="flex flex-col gap-2 md:flex-row">
							{#each [{ afterKey: 'starts_after' as FilterKey, beforeKey: 'starts_before' as FilterKey, label: m['admin.coupon.starts_at']() }, { afterKey: 'ends_after' as FilterKey, beforeKey: 'ends_before' as FilterKey, label: m['admin.coupon.ends_at']() }] as d}
								<div class="flex flex-1 flex-col gap-1">
									<span class="text-xs text-muted-foreground">{d.label}</span>
									<div class="flex items-center gap-2">
										<Input
											type="date"
											class="flex-1 text-xs"
											bind:value={filters[d.afterKey]}
											max={filters[d.beforeKey] || undefined}
										/>
										<span class="text-xs text-muted-foreground">-</span>
										<Input
											type="date"
											class="flex-1 text-xs"
											bind:value={filters[d.beforeKey]}
											min={filters[d.afterKey] || undefined}
										/>
									</div>
								</div>
							{/each}
						</div>
					</div>
				</Accordion.Content>
			</Accordion.Item>
		</Accordion.Root>
		<Separator class="w-full" orientation="horizontal" />
		<div class="flex items-center gap-2">
			<Button class="cursor-pointer" onclick={applyFilters}
				>{m['admin.coupon.filter.apply']()}</Button
			>
			<Button class="cursor-pointer" variant="ghost" onclick={clearFilters}
				>{m['admin.coupon.filter.clear']()}</Button
			>
			<Button onclick={openCreate} class="ml-auto hidden cursor-pointer items-center gap-2 md:flex">
				<Plus />
				{m['admin.coupon.action.new']()}
			</Button>
		</div>
		<Button
			onclick={openCreate}
			class="flex w-full cursor-pointer items-center justify-center gap-2 md:hidden"
		>
			<Plus />
			{m['admin.coupon.action.new']()}
		</Button>
	</div>
	<div class="flex flex-col gap-1 md:hidden">
		{#if data.length === 0}
			<p class="py-10 text-center text-muted-foreground">{m['admin.coupon.no_results']()}</p>
		{:else}
			{#each data as coupon (coupon.id)}
				<div class="py-3">
					<p class="text-lg font-medium">{coupon.discount}%</p>
					<p class="text-sm text-muted-foreground">
						{coupon.code ?? m['admin.coupon.type_discount']()}
					</p>
					<p class="text-sm text-muted-foreground">
						{coupon.starts_at.slice(0, 10)} - {coupon.ends_at.slice(0, 10)}
					</p>
					<div class="mt-3 flex gap-2">
						<Button
							class="flex-1 cursor-pointer"
							onclick={() => openEdit(coupon)}
							variant="outline"
							size="icon"
							aria-label={m['admin.coupon.action.edit']()}
						>
							<Pencil class="size-4" />
						</Button>
						<Button
							class="flex-1 cursor-pointer text-destructive"
							onclick={() => (deleteTarget = coupon)}
							variant="outline"
							size="icon"
							aria-label={m['admin.coupon.action.delete']()}
						>
							<Trash class="size-4" />
						</Button>
					</div>
				</div>
			{/each}
		{/if}
	</div>
	<div class="hidden md:block">
		<Table.Root>
			<Table.Header>
				{#each table.getHeaderGroups() as headerGroup (headerGroup.id)}
					<Table.Row>
						{#each headerGroup.headers as header (header.id)}
							<Table.Head colspan={header.colSpan}>
								{#if !header.isPlaceholder}
									<FlexRender
										content={header.column.columnDef.header}
										context={header.getContext()}
									/>
								{/if}
							</Table.Head>
						{/each}
					</Table.Row>
				{/each}
			</Table.Header>
			<Table.Body>
				{#each table.getRowModel().rows as row (row.id)}
					<Table.Row>
						{#each row.getVisibleCells() as cell (cell.id)}
							<Table.Cell>
								<FlexRender content={cell.column.columnDef.cell} context={cell.getContext()} />
							</Table.Cell>
						{/each}
					</Table.Row>
				{:else}
					<Table.Row>
						<Table.Cell colspan={cols.length} class="h-24 text-center text-muted-foreground">
							{m['admin.coupon.no_results']()}
						</Table.Cell>
					</Table.Row>
				{/each}
			</Table.Body>
		</Table.Root>
	</div>
	<div class="flex items-center justify-center gap-2 pt-12 pb-24">
		<Pagination.Root
			count={meta.total}
			perPage={meta.per_page}
			page={currentPage}
			onPageChange={(p) => {
				currentPage = p;
				const params = new URLSearchParams(page.url.searchParams);
				params.set('page', String(p));
				goto(`?${params}`, { keepFocus: true });
			}}
		>
			{#snippet children({ pages, currentPage })}
				<Pagination.Content>
					<Pagination.Item><Pagination.PrevButton /></Pagination.Item>
					{#each pages as pg (pg.key)}
						{#if pg.type === 'ellipsis'}
							<Pagination.Item><Pagination.Ellipsis /></Pagination.Item>
						{:else}
							<Pagination.Item>
								<Pagination.Link page={pg} isActive={currentPage === pg.value}
									>{pg.value}</Pagination.Link
								>
							</Pagination.Item>
						{/if}
					{/each}
					<Pagination.Item><Pagination.NextButton /></Pagination.Item>
				</Pagination.Content>
			{/snippet}
		</Pagination.Root>
	</div>
</div>
<AlertDialog.Root
	open={!!formTarget}
	onOpenChange={(x) => {
		if (!x) formTarget = null;
	}}
>
	<AlertDialog.Content class="max-h-[90dvh] w-[calc(100%-2rem)] max-w-lg overflow-y-auto">
		<AlertDialog.Header>
			<AlertDialog.Title>
				{formTarget === true ? m['admin.coupon.action.new']() : m['admin.coupon.action.edit']()}
			</AlertDialog.Title>
		</AlertDialog.Header>
		<form method="POST" action={formTarget === true ? '?/create' : '?/update'} use:formEnhance>
			<div class="flex flex-col gap-4 py-2">
				<Form.Field {form} name="type">
					<Form.Control>
						{#snippet children({ props })}
							<Form.Label>{m['admin.coupon.type']()}</Form.Label>
							<input type="hidden" name="type" value={formType} />
							<Select.Root
								type="single"
								value={formType}
								onValueChange={(v) => {
									formType = (v as 'coupon' | 'discount') ?? 'coupon';
									if (formType === 'discount') {
										$formData.book_id = null;
										$formData.genre_id = null;
										$formData.code = null;
									}
								}}
							>
								<Select.Trigger class="w-full cursor-pointer">
									{formType === 'coupon'
										? m['admin.coupon.type_coupon']()
										: m['admin.coupon.type_discount']()}
								</Select.Trigger>
								<Select.Portal>
									<Select.Content>
										<Select.Item value="coupon" class="cursor-pointer"
											>{m['admin.coupon.type_coupon']()}</Select.Item
										>
										<Select.Item value="discount" class="cursor-pointer"
											>{m['admin.coupon.type_discount']()}</Select.Item
										>
									</Select.Content>
								</Select.Portal>
							</Select.Root>
						{/snippet}
					</Form.Control>
				</Form.Field>
				{#if formType === 'coupon'}
					<div class="flex flex-col gap-2 md:flex-row">
						<Button
							type="button"
							variant={scopeType === 'book' ? 'default' : 'outline'}
							class="flex-1 cursor-pointer"
							onclick={() => {
								scopeType = 'book';
								$formData.genre_id = null;
							}}
						>
							{m['admin.coupon.scope_book']()}
						</Button>
						<Button
							type="button"
							variant={scopeType === 'genre' ? 'default' : 'outline'}
							class="flex-1 cursor-pointer"
							onclick={() => {
								scopeType = 'genre';
								$formData.book_id = null;
							}}
						>
							{m['admin.coupon.scope_genre']()}
						</Button>
					</div>
					{#if scopeType === 'book'}
						<Form.Field {form} name="book_id">
							<Form.Control>
								{#snippet children({ props })}
									<Form.Label>{m['admin.coupon.book']()}</Form.Label>
									<input type="hidden" name="book_id" value={$formData.book_id ?? ''} />
									<ComboSelect
										items={bookItems}
										bind:value={$formData.book_id as string}
										placeholder={m['admin.coupon.select_book']()}
										searchPlaceholder={m['admin.coupon.select_book']()}
										onchange={(v) => ($formData.book_id = v as string)}
									/>
								{/snippet}
							</Form.Control>
							<Form.FieldErrors />
						</Form.Field>
					{:else}
						<Form.Field {form} name="genre_id">
							<Form.Control>
								{#snippet children({ props })}
									<Form.Label>{m['admin.coupon.genre']()}</Form.Label>
									<input type="hidden" name="genre_id" value={$formData.genre_id ?? ''} />
									<ComboSelect
										items={genreItems}
										bind:value={$formData.genre_id as string}
										placeholder={m['admin.coupon.select_genre']()}
										searchPlaceholder={m['admin.coupon.select_genre']()}
										onchange={(v) => ($formData.genre_id = v as string)}
									/>
								{/snippet}
							</Form.Control>
							<Form.FieldErrors />
						</Form.Field>
					{/if}
				{/if}
				<Form.Field {form} name="user_id">
					<Form.Control>
						{#snippet children({ props })}
							<Form.Label>{m['admin.coupon.user']()}</Form.Label>
							<input type="hidden" name="user_id" value={$formData.user_id ?? ''} />
							<ComboSelect
								items={userItems}
								bind:value={$formData.user_id as string}
								placeholder={m['admin.coupon.select_user']()}
								searchPlaceholder={m['admin.coupon.select_user']()}
								onchange={(v) => ($formData.user_id = (v as string) || null)}
							/>
						{/snippet}
					</Form.Control>
					<Form.FieldErrors />
				</Form.Field>
				<Form.Field {form} name="discount">
					<Form.Control>
						{#snippet children({ props })}
							<Form.Label>{m['admin.coupon.discount']()}</Form.Label>
							<Input {...props} type="number" min="0" max="100" bind:value={$formData.discount} />
						{/snippet}
					</Form.Control>
					<Form.FieldErrors />
				</Form.Field>
				<div class="flex flex-col gap-4 md:flex-row">
					<Form.Field {form} name="starts_at" class="flex-1">
						<Form.Control>
							{#snippet children({ props })}
								<Form.Label>{m['admin.coupon.starts_at']()}</Form.Label>
								<Input {...props} type="date" bind:value={$formData.starts_at} />
							{/snippet}
						</Form.Control>
						<Form.FieldErrors />
					</Form.Field>
					<Form.Field {form} name="ends_at" class="flex-1">
						<Form.Control>
							{#snippet children({ props })}
								<Form.Label>{m['admin.coupon.ends_at']()}</Form.Label>
								<Input {...props} type="date" bind:value={$formData.ends_at} />
							{/snippet}
						</Form.Control>
						<Form.FieldErrors />
					</Form.Field>
				</div>
				{#if formType === 'coupon'}
					<Form.Field {form} name="code">
						<Form.Control>
							{#snippet children({ props })}
								<Form.Label>{m['admin.coupon.code']()}</Form.Label>
								<Input
									{...props}
									bind:value={$formData.code as string}
									placeholder={m['admin.coupon.code_placeholder']()}
								/>
							{/snippet}
						</Form.Control>
						<Form.FieldErrors />
					</Form.Field>
				{/if}
			</div>
			<AlertDialog.Footer class="mt-2">
				{#if !$submitting}
					<AlertDialog.Cancel type="button" class="cursor-pointer"
						>{m['actions.cancel']()}</AlertDialog.Cancel
					>
				{/if}
				<Button type="submit" disabled={$submitting} class="w-full cursor-pointer md:w-max">
					{#if $submitting}<Spinner />{:else}{m['actions.save']()}{/if}
				</Button>
			</AlertDialog.Footer>
		</form>
	</AlertDialog.Content>
</AlertDialog.Root>
<AlertDialog.Root
	open={!!deleteTarget}
	onOpenChange={(x) => {
		if (!x) deleteTarget = null;
	}}
>
	<AlertDialog.Content>
		<AlertDialog.Header>
			<AlertDialog.Title>{m['admin.coupon.action.delete']()}</AlertDialog.Title>
			<AlertDialog.Description
				>{m['admin.coupon.delete_dialog.description']()}</AlertDialog.Description
			>
		</AlertDialog.Header>
		<AlertDialog.Footer>
			{#if !deleting}
				<AlertDialog.Cancel class="cursor-pointer">{m['actions.cancel']()}</AlertDialog.Cancel>
			{/if}
			<form
				method="POST"
				action="?/delete"
				use:enhance={({ formData }) => {
					formData.append('id', deleteTarget?.id ?? '');
					deleting = true;
					return async ({ result, update }) => {
						if (result.type === 'success') {
							toast.success(m['admin.coupon.action.delete_success']());
							deleteTarget = null;
						} else {
							toast.error(m['messages.server_error']());
						}
						deleting = false;
						await update();
					};
				}}
			>
				<AlertDialog.Action
					class="text-destructive-foreground w-full cursor-pointer bg-destructive hover:bg-destructive/90 md:w-max"
					disabled={deleting}
					type="submit"
				>
					{#if deleting}<Spinner />{:else}{m['admin.coupon.action.delete']()}{/if}
				</AlertDialog.Action>
			</form>
		</AlertDialog.Footer>
	</AlertDialog.Content>
</AlertDialog.Root>
