<script lang="ts">
	import AuthorForm from '$lib/components/AuthorForm.svelte';
	const { data } = $props();
</script>

<AuthorForm {data} />
