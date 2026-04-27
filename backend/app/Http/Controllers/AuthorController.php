<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreAuthorRequest;
use App\Http\Requests\UpdateAuthorRequest;
use App\Http\Resources\AuthorResource;
use App\Models\Author;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Response;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;

class AuthorController extends Controller
{
    use AuthorizesRequests;

    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResource
    {
        $authors = Author::with(['books.publisher', 'books.genre'])->get();
        return AuthorResource::collection($authors);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreAuthorRequest $request): JsonResource
    {
        $this->authorize('manager', $request->user());
        $author = Author::create($request->validated())->load(['books.publisher', 'books.genre']);
        return new AuthorResource($author);
    }

    /**
     * Display the specified resource.
     */
    public function show(Author $author, Request $request): JsonResource
    {
        return new AuthorResource(
            $author->load([
                'books',
                'books.publisher',
                'books.genre',
                'books.authors',
            ])
        );
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateAuthorRequest $request, Author $author): JsonResource
    {
        $this->authorize('manager', $request->user());
        $author->update($request->validated());
        return new AuthorResource($author->load(['books.publisher', 'books.genre']));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Author $author, Request $request): Response
    {
        $this->authorize('manager', $request->user());

        if ($author->books()->count()) {
            $author->books()
                ->withCount('authors')
                ->having('authors_count', 1)
                ->get()
                ->each->delete();
        }

        return $author->delete() ? response()->noContent() : abort(500);
    }
}
