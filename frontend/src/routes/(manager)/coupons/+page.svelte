<script lang="ts">
	import DataTable from '$lib/components/coupons/data-table.svelte';

	const { data } = $props();
</script>

<DataTable
	data={data.coupons}
	meta={data.meta}
	books={data.books}
	genres={data.genres}
	users={data.users}
	form={data.form}
/>
