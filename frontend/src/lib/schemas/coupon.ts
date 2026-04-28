import { z } from 'zod';
import * as m from '$lib/paraglide/messages.js';

export const couponSchema = z
	.object({
		book_id: z
			.uuid({ error: () => m['validation.zod_invalid_type']() })
			.nullable()
			.optional(),
		genre_id: z
			.uuid({ error: () => m['validation.zod_invalid_type']() })
			.nullable()
			.optional(),
		user_id: z
			.uuid({ error: () => m['validation.zod_invalid_type']() })
			.nullable()
			.optional(),
		discount: z
			.number({ error: () => m['validation.zod_invalid_type']() })
			.int()
			.min(0, {
				error: (iss) => m['validation.zod_number_too_low']({ min: iss.minimum as number })
			})
			.max(100, {
				error: (iss) => m['validation.zod_number_too_high']({ max: iss.maximum as number })
			}),
		starts_at: z.string({ error: () => m['validation.zod_invalid_type']() }).min(1, {
			error: () => m['validation.zod_required']()
		}),
		ends_at: z.string({ error: () => m['validation.zod_invalid_type']() }).min(1, {
			error: () => m['validation.zod_required']()
		}),
		code: z
			.string()
			.max(255, {
				error: (iss) => m['validation.zod_string_too_long']({ max: iss.maximum as number })
			})
			.nullable()
			.optional()
	})
	.refine((data) => data.book_id || data.genre_id, {
		error: () => m['admin.coupon.validation.book_or_genre'](),
		path: ['book_id']
	});

export type CouponSchema = typeof couponSchema;
