export default function useDarkMode() {
	let darkMode = $state(false);

	$effect(() => {
		const mq = window.matchMedia('(prefers-color-scheme: dark)');
		darkMode = mq.matches;
		const handler = (e: MediaQueryListEvent) => (darkMode = e.matches);
		mq.addEventListener('change', handler);
		return () => mq.removeEventListener('change', handler);
	});

	return {
		get darkMode() {
			return darkMode;
		}
	};
}
