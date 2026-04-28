<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Author>
 */
class AuthorFactory extends Factory
{
    private static array $authors = [
        ['name' => 'J.R.R. Tolkien'],
        ['name' => 'Frank Herbert'],
        ['name' => 'George Orwell'],
        ['name' => 'Aldous Huxley'],
        ['name' => 'Ray Bradbury'],
        ['name' => 'Patrick Rothfuss'],
        ['name' => 'Douglas Adams'],
        ['name' => 'Orson Scott Card'],
        ['name' => 'Andy Weir'],
        ['name' => 'Neal Stephenson'],
        ['name' => 'William Gibson'],
        ['name' => 'Ursula K. Le Guin'],
        ['name' => 'Dan Simmons'],
        ['name' => 'Isaac Asimov'],
        ['name' => 'Brandon Sanderson'],
        ['name' => 'George R.R. Martin'],
        ['name' => 'Ernest Cline'],
        ['name' => 'Philip K. Dick'],
        ['name' => 'Arthur C. Clarke'],
        ['name' => 'H.G. Wells'],
        ['name' => 'Larry Niven'],
        ['name' => 'Jerry Pournelle'],
        ['name' => 'Gregory Benford'],
    ];

    private static int $index = 0;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $author = self::$authors[self::$index % count(self::$authors)];
        self::$index++;

        return [
            'name' => $author['name'],
        ];
    }
}
