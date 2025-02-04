<?php
session_start();
require 'dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

$username = $_POST['username'];
$password = $_POST['password'];
    $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username");
    $stmt->execute([':username' => $username]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user && password_verify($password, $user['password_hash'])) {
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['username'] = $user['username'];
        $_SESSION['role_id'] = $user['role_id'];

            header("Location: ../index.php");
        exit();
    } else {
        $_SESSION['error'] = "Invalid username or password.";
        header("Location: ../login.php");
        exit();
    }
}
?>