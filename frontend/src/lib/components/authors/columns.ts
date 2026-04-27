import type { ColumnDef } from '@tanstack/table-core';
import { renderComponent, renderSnippet } from '$lib/components/ui/data-table/index.js';
import type { Author } from '$lib/types';
import * as m from '$lib/paraglide/messages.js';
import DataTableActions from './data-table-actions.svelte';
import { createRawSnippet } from 'svelte';

export const columns = (onDelete: (author: Author) => void): ColumnDef<Author>[] => [
	{
		accessorKey: 'name',
		header: m['admin.author.name'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ id: string; name: string }]>((getAuthor) => ({
				render: () => `<a href="/authors/${getAuthor().id}">${getAuthor().name}</a>`
			}));
			return renderSnippet(snippet, { id: row.original.id, name: row.original.name });
		}
	},
	{
		accessorKey: 'biography_en',
		header: m['admin.author.biography_en'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ biography_en: string }]>((getBiography) => ({
				render: () =>
					`<div class="w-36 text-ellipsis overflow-hidden">${getBiography().biography_en ?? '-'}</div>`
			}));
			return renderSnippet(snippet, { biography_en: row.original.biography_en });
		}
	},
	{
		accessorKey: 'biography_hu',
		header: m['admin.author.biography_hu'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ biography_hu: string }]>((getBiography) => ({
				render: () =>
					`<div class="w-36 text-ellipsis overflow-hidden">${getBiography().biography_hu ?? '-'}</div>`
			}));
			return renderSnippet(snippet, { biography_hu: row.original.biography_hu });
		}
	},
	{
		accessorKey: 'books',
		header: m['admin.author.books'](),
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
				onDelete
			})
	}
];
