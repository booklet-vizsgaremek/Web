<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateCouponRequest extends FormRequest
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
            'book_id' => ['nullable', 'uuid', 'exists:books,id'],
            'genre_id' => ['nullable', 'uuid', 'exists:genres,id'],
            'user_id' => ['nullable', 'uuid', 'exists:users,id'],
            'discount' => ['nullable', 'integer', 'min:0', 'max:100'],
            'starts_at' => ['nullable', 'date'],
            'ends_at' => ['nullable', 'date', 'after:starts_at'],
            'code' => ['nullable', 'string', 'max:255', 'unique:coupons,code,' . $this->route('coupon')->id],
        ];
    }
}
