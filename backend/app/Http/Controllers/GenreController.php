<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreGenreRequest;
use App\Http\Requests\UpdateGenreRequest;
use App\Http\Resources\GenreResource;
use App\Models\Genre;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class GenreController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $genres = Genre::with(['books', 'coupons'])->get();
        return GenreResource::collection($genres)->response();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreGenreRequest $request): JsonResponse
    {
        $genre = Genre::create($request->validated())->load(['books', 'coupons']);
        return (new GenreResource($genre))->response()->setStatusCode(201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Genre $genre): JsonResponse
    {
        return (new GenreResource($genre->load(['books', 'coupons'])))->response();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateGenreRequest $request, Genre $genre): JsonResponse
    {
        $genre->update($request->validated());
        return (new GenreResource($genre->load(['books', 'coupons'])))->response();
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Genre $genre): Response
    {
        $genre->delete();
        return response()->noContent();
    }
}
