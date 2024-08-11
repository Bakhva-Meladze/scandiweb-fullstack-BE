<?php

namespace App\model;

use App\Database\Database;
use PDO;

class Products extends Database
{
    protected static string $table = 'products';

    public static function products($category)
    {
        $products = new static();

        if ($category !== "all") {
            $query = "Select * from products where category ='$category'";
            $stmt = $products->conn->query($query);
            $productDetail = $stmt->fetchAll(PDO::FETCH_ASSOC);
            $stmt->fetchAll(PDO::FETCH_ASSOC);
        } else {
            $productDetail = Products::all();
        }
        foreach ($productDetail as &$product) {
            self::productDetail($product);
        }

        return $productDetail;
    }

    public static function productDetail(&$product)
    {
        $product['gallery'] = json_decode($product['gallery']);
        $product["prices"] = Prices::getPriceById($product["id"]);
        $product["attributes"] = Attributes::getAttributesById($product["id"]);
    }

    public static function product($productId)
    {
        $products = new static();

        $query = "Select * from products where id ='$productId'";
        $stmt = $products->conn->query($query);
        $productDetail = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($productDetail as &$product) {
            self::productDetail($product);
        }

        return $productDetail[0] ?? [];
    }

    public static function getProductStock($productId)
    {
        $products = new static();
        $query = "Select inStock from products where id ='$productId'";
        $stmt = $products->conn->query($query);
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return $results[0] ?? [];
    }
}