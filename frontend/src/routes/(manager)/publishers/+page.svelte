<script lang="ts">
	import DataTable from '$lib/components/publishers/data-table.svelte';

	const { data } = $props();
</script>

<DataTable data={data.publishers} form={data.form} />
