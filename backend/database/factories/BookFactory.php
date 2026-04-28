<?php

namespace Database\Factories;

use App\Models\Genre;
use App\Models\Publisher;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Book>
 */
class BookFactory extends Factory
{
    private static array $books = [
        ['title' => 'A Hobbit', 'pages' => 310, 'release_year' => 1937, 'author' => 'J.R.R. Tolkien', 'publisher' => 'Gollancz', 'genre' => 'Epikus fantasy'],
        ['title' => 'Dűne', 'pages' => 688, 'release_year' => 1965, 'author' => 'Frank Herbert', 'publisher' => 'Ace Books', 'genre' => 'Űropera'],
        ['title' => '1984', 'pages' => 328, 'release_year' => 1949, 'author' => 'George Orwell', 'publisher' => 'Gollancz', 'genre' => 'Disztópia'],
        ['title' => 'Szép új világ', 'pages' => 311, 'release_year' => 1932, 'author' => 'Aldous Huxley', 'publisher' => 'HarperCollins', 'genre' => 'Disztópia'],
        ['title' => '451 fok Fahrenheit', 'pages' => 256, 'release_year' => 1953, 'author' => 'Ray Bradbury', 'publisher' => 'Bantam Spectra', 'genre' => 'Disztópia'],
        ['title' => 'A szél neve', 'pages' => 662, 'release_year' => 2007, 'author' => 'Patrick Rothfuss', 'publisher' => 'Gollancz', 'genre' => 'Epikus fantasy'],
        ['title' => 'Galaxis útikalauz stopposoknak', 'pages' => 224, 'release_year' => 1979, 'author' => 'Douglas Adams', 'publisher' => 'Del Rey Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'Ender játéka', 'pages' => 352, 'release_year' => 1985, 'author' => 'Orson Scott Card', 'publisher' => 'Tor Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'A marsi', 'pages' => 369, 'release_year' => 2011, 'author' => 'Andy Weir', 'publisher' => 'Del Rey Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'Projektem: Hail Mary', 'pages' => 476, 'release_year' => 2021, 'author' => 'Andy Weir', 'publisher' => 'Del Rey Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'Ready Player One', 'pages' => 374, 'release_year' => 2011, 'author' => 'Ernest Cline', 'publisher' => 'Del Rey Books', 'genre' => 'Kiberpunk'],
        ['title' => 'Hóomlás', 'pages' => 440, 'release_year' => 1992, 'author' => 'Neal Stephenson', 'publisher' => 'Bantam Spectra', 'genre' => 'Kiberpunk'],
        ['title' => 'Neurománc', 'pages' => 271, 'release_year' => 1984, 'author' => 'William Gibson', 'publisher' => 'Ace Books', 'genre' => 'Kiberpunk'],
        ['title' => 'A sötétség bal keze', 'pages' => 286, 'release_year' => 1969, 'author' => 'Ursula K. Le Guin', 'publisher' => 'Ace Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'Hyperion', 'pages' => 482, 'release_year' => 1989, 'author' => 'Dan Simmons', 'publisher' => 'Bantam Spectra', 'genre' => 'Űropera'],
        ['title' => 'Alapítvány', 'pages' => 244, 'release_year' => 1951, 'author' => 'Isaac Asimov', 'publisher' => 'Bantam Spectra', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'A királyok útja', 'pages' => 1007, 'release_year' => 2010, 'author' => 'Brandon Sanderson', 'publisher' => 'Tor Books', 'genre' => 'Epikus fantasy'],
        ['title' => 'Acélinkvizíció', 'pages' => 541, 'release_year' => 2006, 'author' => 'Brandon Sanderson', 'publisher' => 'Tor Books', 'genre' => 'Epikus fantasy'],
        ['title' => 'A trónok harca', 'pages' => 694, 'release_year' => 1996, 'author' => 'George R.R. Martin', 'publisher' => 'Bantam Spectra', 'genre' => 'Epikus fantasy'],
        ['title' => 'Ubik', 'pages' => 224, 'release_year' => 1969, 'author' => 'Philip K. Dick', 'publisher' => 'Gollancz', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'A jó öregek', 'pages' => 324, 'release_year' => 1992, 'author' => 'Larry Niven', 'publisher' => 'Tor Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'Pokolcsillag', 'pages' => 544, 'release_year' => 1974, 'author' => 'Larry Niven', 'publisher' => 'Tor Books', 'genre' => 'Tudományos-fantasztikus'],
        ['title' => 'A jövő árnyéka', 'pages' => 413, 'release_year' => 1999, 'author' => 'Arthur C. Clarke', 'publisher' => 'Tor Books', 'genre' => 'Tudományos-fantasztikus'],
    ];

    private static int $index = 0;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $book = self::$books[self::$index % count(self::$books)];
        self::$index++;

        return [
            'title' => $book['title'],
            'pages' => $book['pages'],
            'release_year' => $book['release_year'],
            'price' => $this->faker->numberBetween(1990, 6990),
            'stock' => $this->faker->numberBetween(0, 50),
            'img_path' => null,
            'publisher_id' => Publisher::where('name', $book['publisher'])->first()->id,
            'genre_id' => Genre::where('name_hu', $book['genre'])->first()->id,
        ];
    }
}
