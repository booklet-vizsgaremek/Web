import { API_URL } from '$env/static/private';
import { fail } from '@sveltejs/kit';
import type { PageServerLoad, Actions } from './$types';
import * as m from '$lib/paraglide/messages.js';
import { message, superValidate } from 'sveltekit-superforms';
import { zod4 } from 'sveltekit-superforms/adapters';
import { couponSchema } from '$lib/schemas/coupon';

const getHeaders = (cookies: any) => ({
	Authorization: `Bearer ${cookies.get('auth_token')}`,
	'X-Requested-With': 'XMLHttpRequest'
});

const buildBody = (data: any) => {
	const body: Record<string, any> = {
		discount: data.discount,
		starts_at: data.starts_at,
		ends_at: data.ends_at
	};
	if (data.book_id) body.book_id = data.book_id;
	if (data.genre_id) body.genre_id = data.genre_id;
	if (data.user_id) body.user_id = data.user_id;
	if (data.code) body.code = data.code;
	return body;
};

export const load: PageServerLoad = async ({ fetch, cookies, url }) => {
	const headers = getHeaders(cookies);
	const filters = url.searchParams.size ? `?${url.searchParams}` : '';

	const [couponsRes, booksRes, genresRes, usersRes] = await Promise.all([
		fetch(`${API_URL}/coupons${filters}`, { headers }),
		fetch(`${API_URL}/books`, { headers }),
		fetch(`${API_URL}/genres`, { headers }),
		fetch(`${API_URL}/users`, { headers })
	]);

	const coupons = await couponsRes.json();
	const { data: books } = await booksRes.json();
	const { data: genres } = await genresRes.json();
	const { data: users } = await usersRes.json();

	return {
		title: m['title.coupons'](),
		coupons: coupons.data ?? [],
		meta: coupons.meta,
		books: books ?? [],
		genres: genres ?? [],
		users: users ?? [],
		form: await superValidate(zod4(couponSchema))
	};
};

export const actions: Actions = {
	delete: async ({ request, fetch, cookies }) => {
		const formData = await request.formData();
		const response = await fetch(`${API_URL}/coupons/${formData.get('id')}`, {
			method: 'DELETE',
			headers: getHeaders(cookies)
		});
		if (!response.ok) return fail(response.status, { error: m['messages.server_error']() });
		return { success: true };
	},
	create: async ({ request, fetch, cookies }) => {
		const form = await superValidate(request, zod4(couponSchema));
		if (!form.valid) return fail(400, { form });

		const response = await fetch(`${API_URL}/coupons`, {
			method: 'POST',
			headers: { ...getHeaders(cookies), 'Content-Type': 'application/json' },
			body: JSON.stringify(buildBody(form.data))
		});

		if (!response.ok) return fail(response.status, { form });
		return message(form, { success: true });
	},
	update: async ({ request, fetch, cookies }) => {
		const formData = await request.formData();
		const form = await superValidate(formData, zod4(couponSchema));
		if (!form.valid) return fail(400, { form });

		const id = formData.get('id');
		const response = await fetch(`${API_URL}/coupons/${id}`, {
			method: 'PUT',
			headers: { ...getHeaders(cookies), 'Content-Type': 'application/json' },
			body: JSON.stringify(buildBody(form.data))
		});

		if (!response.ok) return fail(response.status, { form });
		return message(form, { success: true });
	}
};
