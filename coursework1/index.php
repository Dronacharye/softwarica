<?php
session_start();
require './php/dbconnection.php';
if (!isset($_SESSION['username'])) {
    $_SESSION['error'] = "You Must Login first";
    header("Location: ./login.php");
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inventory Management Dashboard</title>
    <link rel="stylesheet" href="index.css">
</head>

<body>
    <?php include './php/navbar.php'; ?>

    <div class="dashboard-container">
        <h1>Inventory Dashboard</h1>
    </div>
    <div class="summary-cards">
        <div class="card">
            <h3>Total Items</h3>
            <div class="metric-value">
                <?php
                $stmt = $pdo->prepare("select sum(quantity*price) as totalValue from stock_movements s,products p where s.product_id = p.product_id");
                $stmt->execute();
                $product_value = $stmt->fetch(PDO::FETCH_ASSOC);
                echo $product_value['totalValue']
                ?>
            </div>

        </div>

        <div class="card">
            <h3>Low Stock Items</h3>
            <div class="metric-value low-stock">
                <?php
                $stmt = $pdo->prepare("SELECT SUM(cnt) as data FROM (SELECT IFNULL(COUNT(*), 0) AS cnt FROM stock_movements s GROUP BY s.product_id HAVING SUM(s.quantity) < 100) AS subquery");
                $stmt->execute();
                $lowData = $stmt->fetch(PDO::FETCH_ASSOC);
                echo $lowData['data']
                ?>
            </div>
        </div>

        <div class="card">
            <h3>Out of Stock</h3>
            <div class="metric-value">
                <?php
                $stmt = $pdo->prepare("SELECT IFNULL(COUNT(*), 0) AS total_count FROM stock_movements s WHERE s.quantity <= 0");
                $stmt->execute();
                $lowData = $stmt->fetch(PDO::FETCH_ASSOC);
                echo $lowData['total_count']
                ?>
            </div>
        </div>

        <div class="card">
            <h3>Total Inventory Value</h3>
            <div class="metric-value">
                <?php
                $stmt = $pdo->prepare("select sum(quantity*price) as totalValue from stock_movements s,products p where s.product_id = p.product_id");
                $stmt->execute();
                $product_value = $stmt->fetch(PDO::FETCH_ASSOC);
                echo $product_value['totalValue']
                ?>
            </div>
        </div>
    </div>
    <div class="recent-activity">
        <div class="card">
            <h3>Recent Activity</h3>
            <?php
            $stmt = $pdo->prepare("
                            select s.date,(select name from products p where p.product_id = s.product_id ) as item_name ,movement_type,quantity
                            from stock_movements s order by date desc
                        ");
            $stmt->execute();
            $activities = $stmt->fetchAll(PDO::FETCH_ASSOC);
            ?>
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Item</th>
                        <th>Activity</th>
                        <th>Qty Change</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    foreach ($activities as $activity) {
                        $formatted_time = date("Y-m-d h:i A", strtotime($activity['date']));
                    ?>
                        <tr>
                            <td><?php echo $formatted_time; ?></td>
                            <td><?php echo htmlspecialchars($activity['item_name']); ?></td>
                            <td><?php echo htmlspecialchars($activity['movement_type']); ?></td>
                            <td><?php echo htmlspecialchars($activity['quantity']); ?></td>
                        </tr>
                    <?php
                    }
                    ?>
                </tbody>
            </table>
        </div>
        <div class="recent-activity">
        <?php if (isset($_SESSION['role_id']) && ($_SESSION['role_id'] == "1")) { ?>
            <div class="card">

                <h3>Acitive User</h3>
                <?php
                $stmt = $pdo->prepare("
                            select username,ifnull((select role_name from roles WHERE roles.role_id = users.role_id),'Staff')
                             as role,user_id as id from users

                        ");
                $stmt->execute();

                $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
                ?>
                
                
                    <table>
                        <thead>
                            <tr>
                                <th>User Id</th>
                                <th>Username</th>
                                <th>Role</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            if (isset($_SESSION['role_id']) && ($_SESSION['role_id'] == "1")) {
                                foreach ($users as $user) {
                            ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($user['id']); ?></td>
                                        <td><?php echo htmlspecialchars($user['username']); ?></td>
                                        <td><?php echo htmlspecialchars($user['role']); ?></td>
                                        <td>
                                            <a onclick="return confirm('Are you sure you want to delete this user?');"
                                                href="./php/userdelete.php?id=<?php echo urlencode($user['id']); ?>&username=<?php echo urlencode($user['username']); ?>">
                                                Delete
                                            </a>
                                        </td>
                                    </tr>
                        <?php
                                }
                            }
                        
                        ?>

                        </tbody>
                    </table>
            </div>
            <?php } ?>
        </div>
</body>

</html>