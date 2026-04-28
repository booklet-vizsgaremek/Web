import type { ColumnDef } from '@tanstack/table-core';
import { renderComponent, renderSnippet } from '$lib/components/ui/data-table/index.js';
import type { Coupon } from '$lib/types';
import * as m from '$lib/paraglide/messages.js';
import DataTableActions from './data-table-actions.svelte';
import { createRawSnippet } from 'svelte';

export const columns = (
	onDelete: (coupon: Coupon) => void,
	onEdit: (coupon: Coupon) => void
): ColumnDef<Coupon>[] => [
	{
		accessorKey: 'discount',
		header: m['admin.coupon.discount'](),
		cell: ({ row }) => {
			const snippet = createRawSnippet<[{ discount: number }]>((get) => ({
				render: () => `<div class="w-24 overflow-hidden text-ellipsis">${get().discount}%</div>`
			}));
			return renderSnippet(snippet, { discount: row.original.discount });
		}
	},
	{
		id: 'scope',
		header: m['admin.coupon.type'](),
		cell: ({ row }) => {
			const coupon = row.original;
			let label: string;
			if (coupon.book_id) {
				label = coupon.book
					? `${m['admin.coupon.scope_book']()}: ${(coupon.book as any).title ?? coupon.book_id}`
					: `${m['admin.coupon.scope_book']()}: ${coupon.book_id}`;
			} else if (coupon.genre_id) {
				label = coupon.genre
					? `${m['admin.coupon.scope_genre']()}: ${(coupon.genre as any).name_hu ?? coupon.genre_id}`
					: `${m['admin.coupon.scope_genre']()}: ${coupon.genre_id}`;
			} else {
				label = '-';
			}
			const snippet = createRawSnippet<[{ label: string }]>((get) => ({
				render: () =>
					`<div class="max-w-40 overflow-hidden text-ellipsis whitespace-nowrap">${get().label}</div>`
			}));
			return renderSnippet(snippet, { label });
		}
	},
	{
		id: 'coupon_type',
		header: m['admin.coupon.code'](),
		cell: ({ row }) => {
			const code = row.original.code;
			const snippet = createRawSnippet<[{ code: string | null }]>((get) => ({
				render: () =>
					`<div class="w-32 overflow-hidden text-ellipsis">${get().code ? `<code class="bg-muted px-1 py-0.5 text-xs">${get().code}</code>` : `<span class="text-muted-foreground text-xs">-</span>`}</div>`
			}));
			return renderSnippet(snippet, { code });
		}
	},
	{
		accessorKey: 'starts_at',
		header: m['admin.coupon.starts_at'](),
		cell: ({ row }) => {
			const date = new Date(row.original.starts_at).toLocaleDateString('hu-HU');
			const snippet = createRawSnippet<[{ date: string }]>((get) => ({
				render: () => `<div class="w-28">${get().date}</div>`
			}));
			return renderSnippet(snippet, { date });
		}
	},
	{
		accessorKey: 'ends_at',
		header: m['admin.coupon.ends_at'](),
		cell: ({ row }) => {
			const date = new Date(row.original.ends_at).toLocaleDateString('hu-HU');
			const snippet = createRawSnippet<[{ date: string }]>((get) => ({
				render: () => `<div class="w-28">${get().date}</div>`
			}));
			return renderSnippet(snippet, { date });
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
