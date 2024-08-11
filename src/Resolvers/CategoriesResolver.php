<?php

namespace App\Resolvers;

use App\model\Category;

class CategoriesResolver
{
    public static function index(): array
    {
        return Category::all();// Fetch data
    }
}