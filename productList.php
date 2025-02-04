<?php
session_start();
require './php/dbconnection.php';
    $stmt = $pdo->query("SELECT * FROM products");
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);

 echo "<select>";
        foreach ($products as $product) {
            echo "<option value= {$product['product_id']}>
                    {$product['name']}
                  </option>";
        }
        echo "</select>";
?>