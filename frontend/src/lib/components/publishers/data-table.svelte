<script lang="ts">
	import * as m from '$lib/paraglide/messages.js';
	import * as Table from '$lib/components/ui/table/index.js';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import { Input } from '$lib/components/ui/input/index.js';
	import { toast } from 'svelte-sonner';
	import { enhance } from '$app/forms';
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
	import type { Publisher } from '$lib/types';
	import { columns } from './columns.js';
	import * as Pagination from '$lib/components/ui/pagination/';
	import Button from '$lib/components/ui/button/button.svelte';
	import { Pencil, Plus, Search, Trash } from '@lucide/svelte';
	import Spinner from '$lib/components/ui/spinner/spinner.svelte';
	import { superForm } from 'sveltekit-superforms';
	import * as Form from '$lib/components/ui/form';

	type DataTableProps = {
		data: Publisher[];
		form: any;
	};

	let { data, form: formProp }: DataTableProps = $props();

	// svelte-ignore state_referenced_locally
	const form = superForm(formProp, {
		resetForm: true,
		onSubmit({ formData }) {
			if (formTarget !== true && formTarget !== null) formData.append('id', formTarget.id);
		},
		onUpdated({ form }) {
			if (form.valid) {
				toast.success(
					formTarget === true
						? m['admin.publisher.action.create_success']()
						: m['admin.publisher.action.edit_success']()
				);
				formTarget = null;
			} else {
				toast.error(m['messages.server_error']());
			}
		}
	});

	const { form: formData, enhance: formEnhance, submitting } = form;

	let deleteTarget = $state<Publisher | null>(null);
	let deleting = $state(false);

	let formTarget = $state<Publisher | true | null>(null);

	const cols = columns(
		(publisher) => (deleteTarget = publisher),
		(publisher) => {
			formTarget = publisher;
			$formData.id = publisher.id;
			$formData.name = publisher.name;
		}
	);

	let pagination = $state<PaginationState>({ pageIndex: 0, pageSize: 10 });
	let sorting = $state<SortingState>([]);
	let columnFilters = $state<ColumnFiltersState>([]);
	let columnVisibility = $state<VisibilityState>({});

	let globalFilter = $state('');

	const table = createSvelteTable({
		get data() {
			return data;
		},
		columns: cols,
		globalFilterFn: 'includesString',
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
			},
			get globalFilter() {
				return globalFilter;
			}
		},
		getCoreRowModel: getCoreRowModel(),
		getPaginationRowModel: getPaginationRowModel(),
		getSortedRowModel: getSortedRowModel(),
		getFilteredRowModel: getFilteredRowModel(),
		onPaginationChange: (updater) => {
			pagination = typeof updater === 'function' ? updater(pagination) : updater;
		},
		onSortingChange: (updater) => {
			sorting = typeof updater === 'function' ? updater(sorting) : updater;
		},
		onColumnFiltersChange: (updater) => {
			columnFilters = typeof updater === 'function' ? updater(columnFilters) : updater;
		},
		onColumnVisibilityChange: (updater) => {
			columnVisibility = typeof updater === 'function' ? updater(columnVisibility) : updater;
		},
		onGlobalFilterChange: (updater) => {
			globalFilter = typeof updater === 'function' ? updater(globalFilter) : updater;
		}
	});
</script>

<div class="mx-auto w-full px-4 pt-16 md:w-4/5 md:px-0">
	<h1 class="mb-6 text-3xl">{m['title.publishers']()}</h1>
	<div class="mb-6">
		<div class="mb-6 flex flex-row justify-between gap-2">
			<div class="relative flex-1 md:w-1/2">
				<Search class="absolute top-1/2 left-3 size-4 -translate-y-1/2 text-muted-foreground" />
				<Input
					placeholder="{m['admin.publisher.action.search']()}..."
					value={globalFilter}
					oninput={(e) => table.setGlobalFilter(e.currentTarget.value)}
					onchange={(e) => table.setGlobalFilter(e.currentTarget.value)}
					class="pl-9"
				/>
			</div>
			<Button
				onclick={() => {
					formTarget = true;
					$formData.id = undefined;
					$formData.name = '';
				}}
				class="flex cursor-pointer items-center gap-2"
			>
				<Plus />
				{m['admin.publisher.action.new']()}
			</Button>
		</div>
		<div class="flex w-full flex-col gap-5 px-4 md:hidden">
			{#if data.length === 0}
				<p class="py-10 text-center text-muted-foreground">{m['no_results']()}.</p>
			{:else}
				{#each data as publisher (publisher.id)}
					<div>
						<h2 class="text-xl">{publisher.name}</h2>
						<p
							class="line-clamp-1 w-full overflow-hidden text-sm text-ellipsis text-muted-foreground"
						>
							{m['admin.publisher.books']()}:
							{publisher.books.length}
						</p>
						<div class="mt-4 flex flex-row gap-2">
							<Button
								class="w-1/2"
								onclick={() => {
									formTarget = publisher;
									$formData.name = publisher.name;
								}}
								variant="outline"
							>
								<Pencil size={16} />
							</Button>
							<Button
								class="w-1/2 text-destructive"
								onclick={() => (deleteTarget = publisher)}
								variant="outline"
							>
								<Trash size={16} />
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
							<Table.Cell colspan={cols.length} class="h-24 text-center">
								{m['no_results']()}.
							</Table.Cell>
						</Table.Row>
					{/each}
				</Table.Body>
			</Table.Root>
			<div class="flex items-center justify-center gap-2 pt-12 pb-24">
				<Pagination.Root
					count={table.getFilteredRowModel().rows.length}
					perPage={pagination.pageSize}
					page={pagination.pageIndex + 1}
					onPageChange={(p) => table.setPageIndex(p - 1)}
				>
					{#snippet children({ pages, currentPage })}
						<Pagination.Content>
							<Pagination.Item><Pagination.PrevButton /></Pagination.Item>
							{#each pages as pg (pg.key)}
								{#if pg.type === 'ellipsis'}
									<Pagination.Item><Pagination.Ellipsis /></Pagination.Item>
								{:else}
									<Pagination.Item>
										<Pagination.Link page={pg} isActive={currentPage === pg.value}>
											{pg.value}
										</Pagination.Link>
									</Pagination.Item>
								{/if}
							{/each}
							<Pagination.Item><Pagination.NextButton /></Pagination.Item>
						</Pagination.Content>
					{/snippet}
				</Pagination.Root>
			</div>
		</div>
	</div>
</div>

<AlertDialog.Root
	open={!!formTarget}
	onOpenChange={(x) => {
		if (!x) formTarget = null;
	}}
>
	<AlertDialog.Content>
		<AlertDialog.Header>
			<AlertDialog.Title>
				{formTarget === true
					? m['admin.publisher.action.new']()
					: m['admin.publisher.action.edit']()}
			</AlertDialog.Title>
		</AlertDialog.Header>
		<form method="POST" action={formTarget === true ? '?/create' : '?/update'} use:formEnhance>
			<div class="flex flex-col gap-4 py-2">
				<Form.Field {form} name="name">
					<Form.Control>
						{#snippet children({ props })}
							<Form.Label>{m['admin.publisher.name']()}</Form.Label>
							<Input {...props} bind:value={$formData.name} />
						{/snippet}
					</Form.Control>
					<Form.FieldErrors />
				</Form.Field>
			</div>
			<AlertDialog.Footer class="mt-2">
				{#if !$submitting}
					<AlertDialog.Cancel type="button" class="cursor-pointer">
						{m['actions.cancel']()}
					</AlertDialog.Cancel>
				{/if}
				<Button type="submit" disabled={$submitting} class="w-full cursor-pointer md:w-max">
					{#if $submitting}
						<Spinner />
					{:else}
						{m['actions.save']()}
					{/if}
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
			<AlertDialog.Title>{m['admin.publisher.action.delete']()}</AlertDialog.Title>
			<AlertDialog.Description>
				<div class="flex flex-col gap-4">
					{#if data.find((x) => x.id === deleteTarget?.id)?.books.length}
						<span>
							{m['admin.publisher.delete_dialog.has_books']()}
						</span>
					{/if}
					<span>
						{m['admin.publisher.delete_dialog.description']({ name: deleteTarget?.name ?? '' })}
					</span>
				</div>
			</AlertDialog.Description>
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
							toast.success(m['admin.publisher.action.delete_success']());
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
					{#if deleting}
						<Spinner />
					{:else}
						{m['admin.publisher.action.delete']()}
					{/if}
				</AlertDialog.Action>
			</form>
		</AlertDialog.Footer>
	</AlertDialog.Content>
</AlertDialog.Root>
