<?php

namespace App\Controller;

use App\GraphQL\Mutation;
use GraphQL\GraphQL as GraphQLBase;
use GraphQL\Type\Schema;
use GraphQL\Type\SchemaConfig;
use RuntimeException;
use Throwable;
use App\Graphql\Query;

class GraphQL
{
    static public function handle()
    {
        try {
            $queryType = Query::defineQueries();
            $mutationType = Mutation::defineMutations();

            $schema = new Schema(
                (new SchemaConfig())
                    ->setQuery($queryType)
                    ->setMutation($mutationType)
            );

            $output = self::executeQuery($schema);
        } catch (Throwable $e) {
            $output = [
                'error' => [
                    'message' => $e->getMessage(),
                ],
            ];
        }

        return json_encode($output);
    }

    private static function executeQuery($schema): array
    {
        $rawInput = file_get_contents('php://input');
        if ($rawInput === false) {
            throw new RuntimeException('Failed to get php://input');
        }

        $input = json_decode($rawInput, true);
        $query = $input['query'] ?? null;
        $variableValues = $input['variables'] ?? null;
        $rootValue = [];

        $result = GraphQLBase::executeQuery($schema, $query, $rootValue, null, $variableValues);

        return $result->toArray();
    }
}