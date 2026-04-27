import { z } from 'zod';
import * as m from '$lib/paraglide/messages.js';

export const genreSchema = z.object({
	name_hu: z
		.string({ error: () => m['validation.zod_invalid_type']() })
		.min(1, {
			error: (iss) => m['validation.zod_string_too_short']({ min: iss.minimum as number })
		})
		.max(30, {
			error: (iss) => m['validation.zod_string_too_long']({ max: iss.maximum as number })
		}),
	name_en: z
		.string({ error: () => m['validation.zod_invalid_type']() })
		.min(1, {
			error: (iss) => m['validation.zod_string_too_short']({ min: iss.minimum as number })
		})
		.max(30, {
			error: (iss) => m['validation.zod_string_too_long']({ max: iss.maximum as number })
		})
});

export type GenreSchema = typeof genreSchema;
