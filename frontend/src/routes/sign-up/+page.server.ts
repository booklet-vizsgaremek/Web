import type { PageServerLoad } from './$types.js';
import { superValidate } from 'sveltekit-superforms';
import { signUpSchema } from '$lib/schemas/signUp';
import { zod4 } from 'sveltekit-superforms/adapters';
import { fail } from '@sveltejs/kit';

export const load: PageServerLoad = async () => {
	return {
		titleKey: 'auth.sign_up',
		form: await superValidate(zod4(signUpSchema))
	};
};

export const actions = {
	default: async (event) => {
		// TODO: Sign up action
		const form = await superValidate(event, zod4(signUpSchema));

		if (!form.valid)
			return fail(400, {
				form
			});

		return {
			success: true,
			form
		};
	}
};
