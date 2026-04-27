<script lang="ts">
	import DataTable from '$lib/components/genres/data-table.svelte';

	const { data } = $props();
</script>

<DataTable data={data.genres} form={data.form} />
