<script lang="ts">
	import { Button } from '$lib/components/ui/button/index.js';
	import { Pencil, Trash } from '@lucide/svelte';
	import type { Author } from '$lib/types';
	import { goto } from '$app/navigation';

	const { row, onDelete }: { row: Author; onDelete: (author: Author) => void } = $props();
</script>

<div class="flex justify-center gap-2">
	<Button
		onclick={() => goto(`/authors/${row.id}/edit`)}
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
