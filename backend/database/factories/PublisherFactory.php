<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Publisher>
 */
class PublisherFactory extends Factory
{
    private static array $publishers = [
        'Tor Books',
        'Del Rey Books',
        'Gollancz',
        'Orbit Books',
        'Ace Books',
        'Bantam Spectra',
        'HarperCollins',
        'Subterranean Press',
    ];

    private static int $index = 0;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $publisher = self::$publishers[self::$index % count(self::$publishers)];
        self::$index++;

        return [
            'name' => $publisher,
        ];
    }
}
