<?php

namespace App\Http\Controllers;

use App\Http\Requests\StorePublisherRequest;
use App\Http\Requests\UpdatePublisherRequest;
use App\Http\Resources\PublisherResource;
use App\Models\Publisher;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Response;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class PublisherController extends Controller
{
    use AuthorizesRequests;

    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResource
    {
        $publishers = Publisher::with(['books.authors', 'books.genre'])->get();
        return PublisherResource::collection($publishers);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StorePublisherRequest $request): JsonResource
    {
        $this->authorize('manager', $request->user());
        $publisher = Publisher::create($request->validated())->load(['books.authors', 'books.genre']);
        return new PublisherResource($publisher);
    }

    /**
     * Display the specified resource.
     */
    public function show(Publisher $publisher): JsonResource
    {
        return new PublisherResource($publisher->load(['books.authors', 'books.genre']));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePublisherRequest $request, Publisher $publisher): JsonResource
    {
        $this->authorize('manager', $request->user());
        $publisher->update($request->validated());
        return new PublisherResource($publisher->load(['books.authors', 'books.genre']));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Publisher $publisher, Request $request): Response
    {
        $this->authorize('manager', $request->user());
        $publisher->books()->delete();
        return $publisher->delete() ? response()->noContent() : abort(500);
    }
}
