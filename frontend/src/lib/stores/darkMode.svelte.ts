export default function useDarkMode() {
	let darkMode = $state(false);

	$effect(() => {
		const root = document.documentElement;
		const update = () => (darkMode = root.classList.contains('dark'));
		update();

		const observer = new MutationObserver(update);
		observer.observe(root, {
			attributes: true,
			attributeFilter: ['class']
		});

		return () => observer.disconnect();
	});

	return {
		get darkMode() {
			return darkMode;
		}
	};
}
