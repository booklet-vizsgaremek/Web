<script lang="ts">
	import DataTable from '$lib/components/authors/data-table.svelte';

	const { data } = $props();
</script>

<DataTable data={data.authors} />
