<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Genre extends Model
{
    /** @use HasFactory<\Database\Factories\GenreFactory> */
    use HasFactory;

    public $timestamps = false;

    protected $fillable = [
        'name'
    ];

    public function books(): HasMany
    {
        return $this->hasMany(Book::class, 'genre_id');
    }

    public function coupons(): HasMany
    {
        return $this->hasMany(Coupon::class, 'genre_id');
    }
}
