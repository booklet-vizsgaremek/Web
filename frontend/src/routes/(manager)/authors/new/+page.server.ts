import { API_URL } from '$env/static/private';
import { zod4 } from 'sveltekit-superforms/adapters';
import { superValidate, message } from 'sveltekit-superforms';
import { fail } from '@sveltejs/kit';
import { authorSchema } from '$lib/schemas/author';
import type { PageServerLoad, Actions } from './$types';
import * as m from '$lib/paraglide/messages.js';

export const load: PageServerLoad = async () => {
	return {
		title: m['title.new_author'](),
		form: await superValidate(zod4(authorSchema))
	};
};

export const actions: Actions = {
	default: async ({ request, fetch, cookies }) => {
		const form = await superValidate(request, zod4(authorSchema));
		if (!form.valid) return fail(400, { form });

		const response = await fetch(`${API_URL}/authors`, {
			method: 'POST',
			headers: {
				Authorization: `Bearer ${cookies.get('auth_token')}`,
				'X-Requested-With': 'XMLHttpRequest',
				'Content-Type': 'application/json',
				Accept: 'application/json'
			},
			body: JSON.stringify(form.data)
		});

		if (!response.ok) return fail(response.status, { form, error: m['messages.server_error']() });

		const { data: author } = await response.json();
		return message(form, { id: author.id });
	}
};
