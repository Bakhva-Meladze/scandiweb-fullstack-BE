<?php

namespace App\types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class AttributeItemsType extends ObjectType
{
    public function __construct()
    {
        parent::__construct([
            'name' => 'Attribute',
            'fields' => [
                'id' => Type::string(),
                'attribute_id' => Type::string(),
                'value' => Type::string(),
                'displayValue' => Type::string(),
            ],
        ]);
    }
}