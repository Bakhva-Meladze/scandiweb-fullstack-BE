<?php

namespace App\model;

use App\Database\Database;
use PDOException;

class OrderItems extends Database
{
    public static function saveOrderItems(
        $orderId,
        $productId,
        $itemAttributes,
        $paidCurrency
    )
    {

        try {
            // Get the database connection
            $conn = self::getConnection();
            // Prepare the SQL query with placeholders
            $query = "
        INSERT INTO order_items (
            order_id, product_id, product_name, attribute_values, 
            paid_amount, paid_currency, created_at, updated_at
        ) VALUES (
            '$orderId', :product_id, 'Nike Air Huarache Le', 
            :attribute_values, '$paidCurrency', 'USD', NOW(), NOW()
        )";

            // Prepare the statement
            $stmt = $conn->prepare($query);

            // Prepare the attribute values as a JSON string
            $itemValues = [];

            foreach ($itemAttributes as $item) {
                $itemValues += [$item['id'] => $item['value']];
            }

            $attribute_values = json_encode($itemValues);
            // Bind parameters to the placeholders
            $stmt->bindParam(':product_id', $productId);
            $stmt->bindParam(':attribute_values', $attribute_values);

            // Execute the statement
            $stmt->execute();

        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
}