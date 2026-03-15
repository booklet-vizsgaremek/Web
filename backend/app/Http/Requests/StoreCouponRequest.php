<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCouponRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; 
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'book_id' => ['required', 'uuid', 'exists:books,id'],
            'genre_id' => ['nullable', 'uuid', 'exists:genres,id'],
            'user_id' => ['required', 'uuid', 'exists:users,id'],
            'discount' => ['required', 'integer', 'min:0', 'max:100'],
            'starts_at' => ['required', 'date'],
            'ends_at' => ['required', 'date', 'after:starts_at'],
            'code' => ['required', 'string', 'max:255', 'unique:coupons,code'],
        ];
    }
}
