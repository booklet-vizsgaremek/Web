import { API_URL } from '$env/static/private';
import { fail } from '@sveltejs/kit';
import type { PageServerLoad, Actions } from './$types';
import * as m from '$lib/paraglide/messages.js';
import { message, superValidate } from 'sveltekit-superforms';
import { zod4 } from 'sveltekit-superforms/adapters';
import { genreSchema } from '$lib/schemas/genre';

export const load: PageServerLoad = async ({ fetch, cookies }) => {
	const res = await fetch(`${API_URL}/genres`, {
		headers: {
			Authorization: `Bearer ${cookies.get('auth_token')}`,
			'X-Requested-With': 'XMLHttpRequest'
		}
	});
	const { data: genres } = await res.json();
	return { title: m['title.genres'](), genres, form: await superValidate(zod4(genreSchema)) };
};

export const actions: Actions = {
	delete: async ({ request, fetch, cookies }) => {
		const formData = await request.formData();
		const response = await fetch(`${API_URL}/genres/${formData.get('id')}`, {
			method: 'DELETE',
			headers: {
				Authorization: `Bearer ${cookies.get('auth_token')}`,
				'X-Requested-With': 'XMLHttpRequest'
			}
		});
		if (!response.ok) return fail(response.status, { error: m['messages.server_error']() });
		return { success: true };
	},
	create: async ({ request, fetch, cookies }) => {
		const form = await superValidate(request, zod4(genreSchema));
		if (!form.valid) return fail(400, { form });

		const response = await fetch(`${API_URL}/genres`, {
			method: 'POST',
			headers: {
				Authorization: `Bearer ${cookies.get('auth_token')}`,
				'X-Requested-With': 'XMLHttpRequest',
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(form.data)
		});

		if (!response.ok) return fail(response.status, { form });
		return message(form, { success: true });
	},
	update: async ({ request, fetch, cookies }) => {
		const formData = await request.formData();
		const form = await superValidate(formData, zod4(genreSchema));
		if (!form.valid) return fail(400, { form });

		const response = await fetch(`${API_URL}/genres/${formData.get('id')}`, {
			method: 'PUT',
			headers: {
				Authorization: `Bearer ${cookies.get('auth_token')}`,
				'X-Requested-With': 'XMLHttpRequest',
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(form.data)
		});

		if (!response.ok) return fail(response.status, { form });
		return message(form, { success: true });
	}
};
