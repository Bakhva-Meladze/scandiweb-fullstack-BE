<?php

namespace App\types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class ProductType extends ObjectType
{
    public function __construct()
    {
        parent::__construct([
            'name' => 'Product',
            'fields' => [
                'id' => Type::string(),
                'name' => Type::string(),
                'inStock' => Type::boolean(),
                'description' => Type::string(),
                'category' => Type::string(),
                'brand' => Type::string(),
                'prices' => Type::listOf(new PriceType()),
                'attributes' => Type::listOf(new AttributeType()),
                'gallery' => Type::listOf(Type::string())
            ],
        ]);
    }
}