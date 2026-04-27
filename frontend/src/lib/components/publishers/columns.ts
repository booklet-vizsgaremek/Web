import type { ColumnDef } from '@tanstack/table-core';
import { renderComponent, renderSnippet } from '$lib/components/ui/data-table/index.js';
import type { Publisher } from '$lib/types';
import * as m from '$lib/paraglide/messages.js';
import DataTableActions from './data-table-actions.svelte';
import { createRawSnippet } from 'svelte';

export const columns = (
	onDelete: (publisher: Publisher) => void,
	onEdit: (publisher: Publisher) => void
): ColumnDef<Publisher>[] => [
	{
		accessorKey: 'name',
		header: m['admin.publisher.name'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ name: string }]>((getPublisher) => ({
				render: () => `<span>${getPublisher().name}</span>`
			}));
			return renderSnippet(snippet, { name: row.original.name });
		}
	},
	{
		accessorKey: 'books',
		header: m['admin.publisher.books'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ books: number }]>((getBooks) => ({
				render: () => `<div>${getBooks().books ?? '-'}</div>`
			}));
			return renderSnippet(snippet, { books: row.original.books.length });
		}
	},
	{
		id: 'actions',
		enableHiding: false,
		cell: ({ row }) =>
			renderComponent(DataTableActions, {
				row: row.original,
				onDelete,
				onEdit
			})
	}
];
