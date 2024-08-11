<?php

namespace App\Resolvers;

use App\model\Attributes;
use App\model\OrderItems;
use App\model\Orders;
use App\model\Products;

class OrdersResolver
{
    public static function store(array $args): string
    {
        if(self::attributeValidation($args['items'])) {
            $response =Orders::createOrder(self::calculateCurrencyAmount($args['items']));
            self::items($args['items'],$response['orderId']);
        }

        return "success";
    }

    public static function items($items,$orderId)
    {
        foreach($items as $item){
            $amaunt = Attributes::selectAmount($item['productId']);
            $paidCurrency =$amaunt['amount'] * $item['quantity'];
            OrderItems::saveOrderItems($orderId,$item['productId'], $item['attributeValues'],$paidCurrency);
        }
    }

    public static function calculateCurrencyAmount($items)
    {
        $prices=0;

        foreach ($items as $item) {
            $amaunt = Attributes::selectAmount($item['productId']);
            $amauntQuantity =$amaunt['amount'] * $item['quantity'];
            $prices +=$amauntQuantity;
        }

        return $prices;
    }

    public static function attributeValidation($items): bool
    {
        foreach ($items as $item) {
            $productStock = Products::getProductStock($item['productId']);

            if ((int)$productStock['inStock'] === 0) {
                http_response_code(400);
                echo json_encode(["error" => "Product isn't inStock"]);

                return false;
            }

            $quantity = Attributes::getAttributesByProductId($item['productId']);

            if (count($item['attributeValues']) !== count($quantity)) {
                http_response_code(400);
                echo json_encode(["error" => "Attribute values are required"]);

                return false;
            }

            foreach ($item['attributeValues'] as $attribute) {
                $validateAttribute = Attributes::validateAttributeItem(
                    $item['productId'],
                    $attribute['id'],
                    $attribute['value']
                );

                if (!count($validateAttribute)) {
                    http_response_code(400);
                    echo json_encode(["error" => "Product with this attribute does not exist"]);

                    return false;
                }
            }
        }

        return true;
    }
}