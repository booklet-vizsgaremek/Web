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
	import type { Author } from '$lib/types';
	import { columns } from './columns.js';
	import * as Pagination from '$lib/components/ui/pagination/';
	import Button from '$lib/components/ui/button/button.svelte';
	import { Pencil, Plus, Search, Trash } from '@lucide/svelte';
	import { goto } from '$app/navigation';

	type DataTableProps = {
		data: Author[];
	};

	let { data }: DataTableProps = $props();

	let deleteTarget = $state<Author | null>(null);
	let deleting = $state(false);

	const cols = columns((author) => (deleteTarget = author));

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
		}
	});
</script>

<div class="mx-auto w-full px-4 pt-16 md:w-4/5 md:px-0">
	<h1 class="mb-6 text-3xl">{m['title.authors']()}</h1>
	<div class="mb-6">
		<div class="mb-6 flex flex-row justify-between gap-2">
			<div class="relative flex-1 md:w-1/2">
				<Search class="absolute top-1/2 left-3 size-4 -translate-y-1/2 text-muted-foreground" />
				<Input
					placeholder="{m['admin.author.action.search']()}..."
					value={(table.getColumn('name')?.getFilterValue() as string) ?? ''}
					oninput={(e) => table.getColumn('name')?.setFilterValue(e.currentTarget.value)}
					onchange={(e) => table.getColumn('name')?.setFilterValue(e.currentTarget.value)}
					class="pl-9"
				/>
			</div>
			<Button onclick={() => goto('/authors/new')} class="flex cursor-pointer items-center gap-2">
				<Plus />
				{m['admin.author.action.new']()}
			</Button>
		</div>
		<div class="flex w-full flex-col gap-5 px-4 md:hidden">
			{#if data.length === 0}
				<p class="py-10 text-center text-muted-foreground">{m['no_results']()}.</p>
			{:else}
				{#each data as author (author.id)}
					<div>
						<h2 class="text-xl">{author.name}</h2>
						<p
							class="line-clamp-1 w-full overflow-hidden text-sm text-ellipsis text-muted-foreground"
						>
							{m['admin.author.biography_en']()}: {author.biography_en ?? '-'}
						</p>
						<p
							class="line-clamp-1 w-full overflow-hidden text-sm text-ellipsis text-muted-foreground"
						>
							{m['admin.author.biography_hu']()}: {author.biography_hu ?? '-'}
						</p>
						<div class="mt-4 flex flex-row gap-2">
							<Button
								class="w-1/2"
								onclick={() => goto(`/authors/${author.id}/edit`)}
								variant="outline"
							>
								<Pencil size={16} />
							</Button>
							<Button
								class="w-1/2 text-destructive"
								onclick={() => (deleteTarget = author)}
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
								{m['no_results']()}
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
	open={!!deleteTarget}
	onOpenChange={(x) => {
		if (!x) deleteTarget = null;
	}}
>
	<AlertDialog.Content>
		<AlertDialog.Header>
			<AlertDialog.Title>{m['admin.author.action.delete']()}</AlertDialog.Title>
			<AlertDialog.Description>
				<div class="flex flex-col gap-4">
					{#if data.find((x) => x.id === deleteTarget?.id)?.books.length}
						<span>
							{m['admin.author.delete_dialog.has_books']()}
						</span>
					{/if}
					<span>
						{m['admin.author.delete_dialog.description']({ name: deleteTarget?.name ?? '' })}
					</span>
				</div>
			</AlertDialog.Description>
		</AlertDialog.Header>
		<AlertDialog.Footer>
			<AlertDialog.Cancel class="cursor-pointer">{m['actions.cancel']()}</AlertDialog.Cancel>
			<form
				method="POST"
				use:enhance={({ formData }) => {
					formData.append('id', deleteTarget?.id ?? '');
					return async ({ result, update }) => {
						if (result.type === 'success') {
							toast.success(m['admin.author.action.delete_author_success']());
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
					{m['admin.author.action.delete']()}
				</AlertDialog.Action>
			</form>
		</AlertDialog.Footer>
	</AlertDialog.Content>
</AlertDialog.Root>
