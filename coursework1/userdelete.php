<?php
include 'dbconnection.php'; 

if (isset($_GET['id']) && is_numeric($_GET['id'])) {
    $userId = $_GET['id'];
    
    $stmt = $pdo->prepare("DELETE FROM users WHERE user_id = :id");
    ;

    if($stmt->execute([':id' => $userId])){
        header("Location: ../index.php");
        exit();
    } else {
        echo "Error deleting user.";
    }
} else {
    echo "Invalid user ID.";
}
?>
