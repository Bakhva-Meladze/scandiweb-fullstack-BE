<?php

namespace App\types;

use GraphQL\Type\Definition\InputObjectType;
use GraphQL\Type\Definition\Type;

class AttributeValueInputType extends InputObjectType
{
    public function __construct()
    {
        parent::__construct([
            'name' => 'AttributeValueInput',
            'fields' => [
                'id' => ['type' => Type::nonNull(Type::string())],
                'value' => ['type' => Type::nonNull(Type::string())],
            ],
        ]);
    }
}