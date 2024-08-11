<?php

namespace App\Database;

use PDO;
use PDOException;

class Database
{
    protected static string $table;
    public $conn;
    public $rootValue;
    private $host = 'localhost';
    private $db_name = 'scandiwebtest2'; // Make sure this database exists
    private $username = 'root';
    private $password = '';


    // Method to establish a database connection
    public function __construct()
    {
        $this->conn = null;

        try {
            $this->conn = new PDO(
                "mysql:host=" . $this->host . ";dbname=" . $this->db_name,
                $this->username,
                $this->password
            );
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo "Connection error: " . $e->getMessage();
        }

        return $this->conn;
    }


    // Method to insert a new record into the table
    public static function all(): ?array
    {
        $query = 'SELECT * FROM ' . static::$table;
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($results)) {
            return null; // No records found
        }

        return $results;
    }


    public static function selectPrices($id): ?array
    {

        $query = "Select * from prices where product_id = '$id'";
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        if (empty($results)) {
            return null; // No records found
        }

        $price = [];

        foreach ($results as $result) {

            $price[] = [
                'amount' => $result['amount'],
                'currency' => [
                    'label' => $result['label'],
                    'symbol' => $result['symbol']
                ]
            ];
        }

        return $price;
    }

    public static function getConnection(): ?PDO
    {
        // Create a new instance of the Database class and return the connection
        $database = new self();

        return $database->conn;
    }

    public static function attributes($productId): array
    {
        $query = "SELECT *, a.id as id FROM attributes a
          LEFT JOIN product_attributes pa ON a.id = pa.attribute_id
          WHERE pa.product_id  ='$productId'";
        $stmt = (new static)->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $attributes = [];

        foreach ($results as $result) {
            $attributeId = $result['attribute_id'];

            // If this attribute_id is not in the $attributes array, add it with its items array
            if (!isset($attributes[$attributeId])) {
                $attributes[$attributeId] = [
                    'id' => $result['id'],
                    'name' => $result['name'],
                    'type' => $result['type'],
                    'items' => []
                ];
            }

            // Add the item to the corresponding attribute's items array
            $attributes[$attributeId]['items'][] = [
                'id' => $result['id'],
                'attribute_id' => $result['attribute_id'],
                'value' => $result['value'],
                'displayValue' => $result['displayValue']
            ];
        }

        $attributes = array_values($attributes);

        return $attributes;
    }
}

