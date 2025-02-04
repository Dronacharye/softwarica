<?php
session_start();
require 'dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $stmt = $pdo->prepare("SELECT product_id,name FROM products");
    $stmt->execute();
    $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
}
?>



<?php
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $productId = $_POST['product'];
    $movement_type = $_POST['action'];
    $quantity = $_POST['quantity'];
    $adjustedQuantity = ($movementType == 'out') ? -$quantity : $quantity;
    $stmt = $pdo->prepare("select max(movement_id) + 1 as movement_id from stock_movements");
    $stmt->execute();
    $cnt = $stmt->fetch(PDO::FETCH_ASSOC);
    $movement_id = $cnt['movement_id'];

    $stmt = $pdo->prepare("
        INSERT INTO stock_movements (movement_id,product_id, quantity, movement_type) 
        VALUES (
            :movement_id,:productId,:quantity,:movement_type)
        ");
    $stmt->execute([
        ':movement_id' => $movement_id,
        ':productId' => $productId,
        ':quantity' => $adjustedQuantity,
        ':movement_type' => $movement_type
    ]);

    header("Location: ../index.php");
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management</title>
    <link rel="stylesheet" href="../index.css">
    <link rel="stylesheet" href="../addActivity.css">
</head>

<body>


    <div class="container">
        <h1 class="form-title">Inventory Adjustment</h1>
        <form method="POST">
            <div class="form-group">
                <label for="product">Product</label>
                <select name="product" id="product" required>
                    <option value="" disabled selected>Select a product</option>
                    <?php
                    foreach ($products as $product) {

                    ?>
                        <option value="<?php echo htmlspecialchars($product['product_id']); ?>">
                            <?php echo htmlspecialchars($product['name']); ?>
                        </option>

                    <?php
                    }
                    ?>
                </select>
            </div>

            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" id="quantity" name="quantity"
                    min="0" required placeholder="Enter quantity">
            </div>

            <div class="form-group">
                <label for="action">Action</label>
                <select name="action" id="action" required>
                    <option value="in">Stock In</option>
                    <option value="out">Stock Out</option>
                </select>
            </div>

            <button type="submit" class="submit-btn">Submit Adjustment</button>
        </form>
    </div>
</body>

</html>