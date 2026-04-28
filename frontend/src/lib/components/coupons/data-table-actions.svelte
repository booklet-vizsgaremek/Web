<script lang="ts">
	import PencilIcon from '@lucide/svelte/icons/pencil';
	import { Trash } from '@lucide/svelte';
	import { Button } from '$lib/components/ui/button/index.js';
	import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js';
	import * as m from '$lib/paraglide/messages.js';
	import type { Coupon } from '$lib/types';
	import Spinner from '$lib/components/ui/spinner/spinner.svelte';
	import { beforeNavigate } from '$app/navigation';

	let {
		row,
		onDelete,
		onEdit
	}: { row: Coupon; onDelete: (coupon: Coupon) => void; onEdit: (coupon: Coupon) => void } =
		$props();

	let deleteDialogOpen = $state(false);
	let deleteLoading = $state(false);

	beforeNavigate(() => {
		deleteDialogOpen = false;
		deleteLoading = false;
	});
</script>

<div class="flex items-center gap-2">
	<Button
		variant="ghost"
		size="icon"
		class="size-8 cursor-pointer text-muted-foreground hover:text-foreground"
		aria-label={m['admin.coupon.action.edit']()}
		onclick={() => onEdit(row)}
	>
		<PencilIcon class="size-4" />
	</Button>
	<AlertDialog.Root bind:open={deleteDialogOpen}>
		<AlertDialog.Trigger>
			{#snippet child({ props }: { props: Record<string, unknown> })}
				<Button
					{...props}
					variant="ghost"
					size="icon"
					class="size-8 cursor-pointer text-muted-foreground hover:text-destructive"
					aria-label={m['admin.coupon.action.delete']()}
				>
					<Trash class="size-4" />
				</Button>
			{/snippet}
		</AlertDialog.Trigger>
		<AlertDialog.Content>
			<AlertDialog.Header>
				<AlertDialog.Title>{m['admin.coupon.action.delete']()}</AlertDialog.Title>
				<AlertDialog.Description>
					{m['admin.coupon.delete_dialog.description']()}
				</AlertDialog.Description>
			</AlertDialog.Header>
			<AlertDialog.Footer>
				{#if !deleteLoading}
					<AlertDialog.Cancel class="cursor-pointer">
						{m['actions.cancel']()}
					</AlertDialog.Cancel>
				{/if}
				<AlertDialog.Action
					class="text-destructive-foreground cursor-pointer bg-destructive hover:bg-destructive/90 disabled:pointer-events-none disabled:opacity-50"
					onclick={() => {
						deleteLoading = true;
						onDelete(row);
					}}
					disabled={deleteLoading}
				>
					{#if deleteLoading}
						<Spinner />
					{:else}
						{m['admin.coupon.action.delete']()}
					{/if}
				</AlertDialog.Action>
			</AlertDialog.Footer>
		</AlertDialog.Content>
	</AlertDialog.Root>
</div>
