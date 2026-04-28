<?php

namespace Database\Seeders;

use App\Models\Author;
use App\Models\Book;
use App\Models\Genre;
use Illuminate\Database\Seeder;

class BookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $books = Book::factory(23)->create();

        $authorMap = [
            'A Hobbit' => ['J.R.R. Tolkien'],
            'Dűne' => ['Frank Herbert'],
            '1984' => ['George Orwell'],
            'Szép új világ' => ['Aldous Huxley'],
            '451 fok Fahrenheit' => ['Ray Bradbury'],
            'A szél neve' => ['Patrick Rothfuss'],
            'Galaxis útikalauz stopposoknak' => ['Douglas Adams'],
            'Ender játéka' => ['Orson Scott Card'],
            'A marsi' => ['Andy Weir'],
            'Projektem: Hail Mary' => ['Andy Weir'],
            'Ready Player One' => ['Ernest Cline'],
            'Hóomlás' => ['Neal Stephenson'],
            'Neurománc' => ['William Gibson'],
            'A sötétség bal keze' => ['Ursula K. Le Guin'],
            'Hyperion' => ['Dan Simmons'],
            'Alapítvány' => ['Isaac Asimov'],
            'A királyok útja' => ['Brandon Sanderson'],
            'Acélinkvizíció' => ['Brandon Sanderson'],
            'A trónok harca' => ['George R.R. Martin'],
            'Ubik' => ['Philip K. Dick'],
            'A jó öregek' => ['Larry Niven', 'Jerry Pournelle'],
            'Pokolcsillag' => ['Larry Niven', 'Jerry Pournelle'],
            'A jövő árnyéka' => ['Arthur C. Clarke', 'Gregory Benford'],
        ];

        foreach ($books as $book) {
            $authorNames = $authorMap[$book->title] ?? [];
            $authorIds = Author::whereIn('name', $authorNames)->pluck('id');
            $book->authors()->attach($authorIds);
        }

        Author::all()->each(function ($author) use ($books) {
            if ($author->books()->count() === 0) {
                $author->books()->attach($books->random()->id);
            }
        });

        Genre::all()->each(function ($genre) use ($books) {
            if ($genre->books()->count() === 0) {
                $book = $books->random();
                $book->genre_id = $genre->id;
                $book->save();
            }
        });
    }
}
