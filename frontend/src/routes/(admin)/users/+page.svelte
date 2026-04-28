<script lang="ts">
	import DataTable from '$lib/components/users/data-table.svelte';
	import type { User } from '$lib/types';

	let {
		data
	}: {
		data: {
			users: User[];
			meta: { per_page: number; total: number };
		};
	} = $props();
</script>

<DataTable {data} />
