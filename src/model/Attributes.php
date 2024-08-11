<?php

namespace App\model;

use App\Database\Database;
use PDO;

class Attributes extends Database
{
    public static function getAttributesById($id): ?array
    {
        return Database::attributes($id);
    }

    public static function getAttributesByProductId($id): ?array
    {
        $query = "SElECT count(*) from product_attributes where product_id ='$id' group by attribute_id";
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    public static function validateAttributeItem($productId, $attributeId, $value)
    {
        $query = "SELECT * FROM product_attributes where product_id ='$productId' AND attribute_id='$attributeId' AND value='$value'";
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $results;
    }

    public static function selectAmount($productId)
    {
        $query = "SELECT prices.amount from prices where product_id ='$productId'";
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $results[0];
    }
}