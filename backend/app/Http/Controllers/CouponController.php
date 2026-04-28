<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCouponRequest;
use App\Http\Requests\UpdateCouponRequest;
use App\Http\Resources\CouponResource;
use App\Models\Coupon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class CouponController extends Controller
{
    use AuthorizesRequests;

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request): JsonResource
    {
        if ($request->boolean('is_valid')) {
            $userId = auth('sanctum')->id();

            $coupons = Coupon::with(['book', 'genre', 'user'])
                ->whereNull('code')
                ->where('starts_at', '<=', now())
                ->where('ends_at', '>=', now())
                ->where(function ($query) use ($userId) {
                    $query->whereNull('user_id');
                    if ($userId) $query->orWhere('user_id', $userId);
                })
                ->get();

            return CouponResource::collection($coupons);
        }

        if (!$request->boolean('is_valid') && $request->user()) $this->authorize('manager');

        $query = Coupon::with(['book', 'genre', 'user']);

        if ($request->filled('scope')) {
            match ($request->scope) {
                'book'  => $query->whereNotNull('book_id'),
                'genre' => $query->whereNotNull('genre_id'),
                default => null,
            };
        }

        if ($request->filled('has_user')) {
            match ($request->has_user) {
                'yes' => $query->whereNotNull('user_id'),
                'no'  => $query->whereNull('user_id'),
                default => null,
            };
        }

        if ($request->filled('starts_after')) $query->where('starts_at', '>=', $request->starts_after);
        if ($request->filled('starts_before')) $query->where('starts_at', '<=', $request->starts_before);
        if ($request->filled('ends_after')) $query->where('ends_at', '>=', $request->ends_after);
        if ($request->filled('ends_before')) $query->where('ends_at', '<=', $request->ends_before);

        return CouponResource::collection(
            $query->orderBy('created_at', 'desc')
                ->paginate($request->integer('per_page', 10))
        );
    }


    public function validate(Request $request): JsonResource|JsonResponse
    {
        $request->validate([
            'code' => ['required', 'string']
        ]);

        $coupon = Coupon::with(['book', 'genre', 'user'])
            ->where('code', $request->code)
            ->where('starts_at', '<=', now())
            ->where('ends_at', '>=', now())
            ->first();

        if (!$coupon) return response()->json(['message_en' => 'Invalid or expired coupon code.', 'message_hu' => 'Érvénytelen vagy lejárt kuponkód.'], 404);

        if ($coupon->user_id && $coupon->user_id !== Auth::id()) return response()->json(['message_en' => 'This coupon is not valid for your account.', 'message_hu' => 'Ezt a kupont nem használhatja fel.'], 403);

        return new CouponResource($coupon);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreCouponRequest $request): JsonResource
    {
        $this->authorize('manager', $request->user());
        $coupon = Coupon::create($request->validated())->load(['book', 'genre', 'user']);
        return new CouponResource($coupon);
    }

    /**
     * Display the specified resource.
     */
    public function show(Coupon $coupon): JsonResource
    {
        return new CouponResource($coupon->load(['book', 'genre', 'user']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateCouponRequest $request, Coupon $coupon): JsonResource
    {
        $this->authorize('manager', $request->user());
        $coupon->update($request->validated());
        return new CouponResource($coupon->load(['book', 'genre', 'user']));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Coupon $coupon, Request $request): Response
    {
        $this->authorize('manager', $request->user());
        return $coupon->delete() ? response()->noContent() : abort(500);
    }
}
