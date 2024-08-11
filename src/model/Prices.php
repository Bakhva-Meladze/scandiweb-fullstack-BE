<?php

namespace App\model;

use App\Database\Database;

class Prices extends Database
{
    public static function getPriceById($id): ?array
    {
        return Database::selectPrices($id);
    }
}