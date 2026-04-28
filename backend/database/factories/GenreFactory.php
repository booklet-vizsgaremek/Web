<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Genre>
 */
class GenreFactory extends Factory
{
    private static array $genres = [
        ['name_hu' => 'Tudományos-fantasztikus', 'name_en' => 'Science Fiction'],
        ['name_hu' => 'Fantasy', 'name_en' => 'Fantasy'],
        ['name_hu' => 'Disztópia', 'name_en' => 'Dystopian'],
        ['name_hu' => 'Kiberpunk', 'name_en' => 'Cyberpunk'],
        ['name_hu' => 'Űropera', 'name_en' => 'Space Opera'],
        ['name_hu' => 'Epikus fantasy', 'name_en' => 'Epic Fantasy'],
        ['name_hu' => 'Kaland', 'name_en' => 'Adventure'],
    ];

    private static int $index = 0;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */

    public function definition(): array
    {
        $genre = self::$genres[self::$index % count(self::$genres)];
        self::$index++;

        return [
            'name_hu' => $genre['name_hu'],
            'name_en' => $genre['name_en'],
        ];
    }
}
