<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('coupons', function (Blueprint $table) {
            $table->uuid("id")->primary();
            $table->foreignUuid("book_id")->nullable();
            $table->foreignUuid("genre_id")->nullable();
            $table->foreignUuid("user_id")->nullable();
            $table->integer("discount");
            $table->dateTime("starts_at");
            $table->dateTime("ends_at");
            $table->string("code")->unique()->default("");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('coupons');
    }
};
