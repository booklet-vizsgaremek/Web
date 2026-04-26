import { z } from 'zod';
import * as m from '$lib/paraglide/messages.js';

export const authorSchema = z.object({
	name: z
		.string({ error: () => m['validation.zod_invalid_type']() })
		.min(4, {
			error: (iss) => m['validation.zod_string_too_short']({ min: iss.minimum as number })
		})
		.max(255, {
			error: (iss) => m['validation.zod_string_too_long']({ max: iss.maximum as number })
		}),
	biography_en: z.string({ error: () => m['validation.zod_invalid_type']() }).nullable(),
	biography_hu: z.string({ error: () => m['validation.zod_invalid_type']() }).nullable()
});

export type AuthorSchema = typeof authorSchema;
