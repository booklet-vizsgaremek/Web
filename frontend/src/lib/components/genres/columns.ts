import type { ColumnDef } from '@tanstack/table-core';
import { renderComponent, renderSnippet } from '$lib/components/ui/data-table/index.js';
import type { Genre } from '$lib/types';
import * as m from '$lib/paraglide/messages.js';
import DataTableActions from './data-table-actions.svelte';
import { createRawSnippet } from 'svelte';

export const columns = (
	onDelete: (genre: Genre) => void,
	onEdit: (genre: Genre) => void
): ColumnDef<Genre>[] => [
	{
		accessorKey: 'name_en',
		header: m['admin.genre.name_en'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ name_en: string }]>((getName) => ({
				render: () =>
					`<div class="w-36 text-ellipsis overflow-hidden">${getName().name_en ?? '-'}</div>`
			}));
			return renderSnippet(snippet, { name_en: row.original.name_en });
		}
	},
	{
		accessorKey: 'name_hu',
		header: m['admin.genre.name_hu'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ name_hu: string }]>((getName) => ({
				render: () =>
					`<div class="w-36 text-ellipsis overflow-hidden">${getName().name_hu ?? '-'}</div>`
			}));
			return renderSnippet(snippet, { name_hu: row.original.name_hu });
		}
	},
	{
		accessorKey: 'books',
		header: m['admin.genre.books'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ books: number }]>((getBooks) => ({
				render: () =>
					`<div class="w-36 text-ellipsis overflow-hidden">${getBooks().books ?? '-'}</div>`
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
