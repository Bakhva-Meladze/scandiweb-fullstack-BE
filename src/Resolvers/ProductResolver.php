<?php

namespace App\Resolvers;

use App\model\Products;

class ProductResolver
{
    public static function products($category)
    {
        return Products::products($category);
    }

    public static function product($id)
    {
        return Products::product($id);
    }
}