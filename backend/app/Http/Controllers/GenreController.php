<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreGenreRequest;
use App\Http\Requests\UpdateGenreRequest;
use App\Http\Resources\GenreResource;
use App\Models\Genre;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Response;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class GenreController extends Controller
{
    use AuthorizesRequests;

    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResource
    {
        $genres = Genre::with(['books', 'coupons'])->get();
        return GenreResource::collection($genres);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreGenreRequest $request): JsonResource
    {
        $this->authorize('manager', $request->user());
        $genre = Genre::create($request->validated())->load(['books', 'coupons']);
        return new GenreResource($genre);
    }

    /**
     * Display the specified resource.
     */
    public function show(Genre $genre): JsonResource
    {
        return new GenreResource($genre->load(['books', 'coupons']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateGenreRequest $request, Genre $genre): JsonResource
    {
        $this->authorize('manager', $request->user());
        $genre->update($request->validated());
        return new GenreResource($genre->load(['books', 'coupons']));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Genre $genre, Request $request): Response
    {
        $this->authorize('manager', $request->user());
        $genre->books()->delete();
        return $genre->delete() ? response()->noContent() : abort(500);
    }
}
