<?php

namespace App\model;

use App\Database\Database;
use PDO;
use PDOException;

class Orders extends Database
{
    public static function createOrder($amount): array
    {
        try {
            $conn = self::getConnection();
            $query = "INSERT INTO orders (total_amount, total_currency, status, created_at, updated_at) 
                      VALUES (:amount, 'USD', 'pending', NOW(), NOW())";
            $stmt = $conn->prepare($query);
            $stmt->bindParam(':amount', $amount, PDO::PARAM_INT);
            $stmt->execute();
            $lastInsertId = $conn->lastInsertId();

            return [
                'success' => true,
                'orderId' => $lastInsertId
            ];
        } catch (PDOException $e) {
            return [
                'success' => false,
                'error' => 'Failed to insert order: ' . $e->getMessage()
            ];
        }
    }
}
