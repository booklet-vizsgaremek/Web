import { API_URL } from '$env/static/private';
import { fail } from '@sveltejs/kit';
import type { PageServerLoad, Actions } from './$types';
import * as m from '$lib/paraglide/messages.js';

export const load: PageServerLoad = async ({ fetch, cookies }) => {
	const res = await fetch(`${API_URL}/authors`, {
		headers: {
			Authorization: `Bearer ${cookies.get('auth_token')}`,
			'X-Requested-With': 'XMLHttpRequest'
		}
	});

	const { data: authors } = await res.json();
	return { title: m['title.authors'](), authors };
};

export const actions: Actions = {
	default: async ({ request, fetch, cookies }) => {
		const formData = await request.formData();
		const id = formData.get('id');

		const response = await fetch(`${API_URL}/authors/${id}`, {
			method: 'DELETE',
			headers: {
				Authorization: `Bearer ${cookies.get('auth_token')}`,
				'X-Requested-With': 'XMLHttpRequest'
			}
		});

		if (!response.ok) {
			return fail(response.status, { error: m['messages.server_error']() });
		}

		return { success: true };
	}
};
