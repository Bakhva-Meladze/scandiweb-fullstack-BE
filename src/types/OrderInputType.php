<?php

namespace App\types;

use GraphQL\Type\Definition\InputObjectType;
use GraphQL\Type\Definition\Type;

class OrderInputType extends InputObjectType
{
    public function __construct()
    {
        parent::__construct([
            'name' => 'OrderInput',
            'fields' => [
                'items' => [
                    'type' => Type::listOf(new OrderItemInputType())
                ],
            ],
        ]);
    }
}