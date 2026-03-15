<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreCouponRequest;
use App\Http\Requests\UpdateCouponRequest;
use App\Http\Resources\CouponResource;
use App\Models\Coupon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class CouponController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $coupons = Coupon::with(['book', 'genre', 'user'])->get();
        return CouponResource::collection($coupons)->response();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreCouponRequest $request): JsonResponse
    {
        $coupon = Coupon::create($request->validated())->load(['book', 'genre', 'user']);
        return (new CouponResource($coupon))->response()->setStatusCode(201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Coupon $coupon): JsonResponse
    {
        return (new CouponResource($coupon->load(['book', 'genre', 'user'])))->response();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateCouponRequest $request, Coupon $coupon): JsonResponse
    {
        $coupon->update($request->validated());
        return (new CouponResource($coupon->load(['book', 'genre', 'user'])))->response();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Coupon $coupon): Response
    {
        $coupon->delete();
        return response()->noContent();
    }
}