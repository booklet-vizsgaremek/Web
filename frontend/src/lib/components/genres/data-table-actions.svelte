<script lang="ts">
	import { Button } from '$lib/components/ui/button/index.js';
	import { Pencil, Trash } from '@lucide/svelte';
	import type { Genre } from '$lib/types';

	const {
		row,
		onDelete,
		onEdit
	}: { row: Genre; onDelete: (genre: Genre) => void; onEdit: (genre: Genre) => void } = $props();
</script>

<div class="flex justify-center gap-2">
	<Button
		onclick={() => onEdit(row)}
		variant="ghost"
		size="icon"
		class="cursor-pointer text-muted-foreground"
	>
		<Pencil size={16} />
	</Button>
	<Button
		variant="ghost"
		size="icon"
		class="cursor-pointer text-muted-foreground hover:text-destructive"
		onclick={() => onDelete(row)}
	>
		<Trash size={16} />
	</Button>
</div>
