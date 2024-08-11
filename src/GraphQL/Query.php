<?php

namespace App\GraphQL;

use App\Resolvers\CategoriesResolver;
use App\Resolvers\ProductResolver;
use App\types\CategoryType;
use App\types\ProductType;
use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class Query
{
    public static function defineQueries(): ObjectType
    {

        $productType = new ProductType();
        return new ObjectType([

            'name' => 'Query',
            'fields' => [
                'echo' => [
                    'type' => Type::string(),
                    'args' => [
                        'message' => ['type' => Type::string()],
                    ],
                    'resolve' => static fn($rootValue, array $args): string => $rootValue['prefix'] . $args['message'],
                ],
                'categories' => [
                    'type' => Type::listOf(new CategoryType()),
                    'resolve' => static fn() => CategoriesResolver::index()
                ],
                'products' => [
                    'type' => Type::listOf($productType),
                    'args' => [
                        'category' => ['type' => Type::string()],
                    ],
                    'resolve' => static fn(
                        $rootValue,
                        array $args
                    ) => ProductResolver::products($args['category'] ?? null),
                ],
                'product' => [
                    'type' => $productType,
                    'args' => [
                        'id' => ['type' => Type::nonNull(Type::string())],
                    ],
                    'resolve' => static fn($rootValue, array $args) => ProductResolver::product($args['id']),
                ],
            ],
        ]);
    }
}