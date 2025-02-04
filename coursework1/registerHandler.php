<?php
session_start();
require 'dbconnection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $role = $_POST['role'];
    $password = $_POST['password'];
    $confirmPassword = $_POST['confirmPassword'];

    if ($password !== $confirmPassword) {
        $_SESSION['error'] = "Passwords do not match.";
        header("Location: ../register.php");
        exit();
    }

$stmt = $pdo->prepare("SELECT COUNT(*) AS count FROM users WHERE username = :username");
$stmt->execute([':username' => $username]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($user['count'] > 0) { 
    $_SESSION['error'] = "Username ".$username ."already exists";
    header("Location: ../register.php"); 
    exit();
}



    try {
        $stmt = $pdo->prepare("SELECT * FROM users WHERE username = :username OR email = :email");
        $stmt->execute([':username' => $username, ':email' => $email]);
        $existingUser = $stmt->fetch();

        if ($existingUser) {
            $_SESSION['error'] = "Username or email already exists.";
            header("Location: ../register.php");
            exit();
        }


        $password_hash = password_hash($password, PASSWORD_DEFAULT);

        $stmt = $pdo->prepare("INSERT INTO users (username, password_hash, email, role_id) VALUES (:username, :password_hash, :email, :role)");
        $stmt->execute([
            ':username' => $username,
            ':password_hash' => $password_hash,
            ':email' => $email,
            ':role' =>  ($role == "Admin") ? 1 : 2
        ]);

        header("Location: ../login.php");
        exit();
    } catch (PDOException $e) {
        $_SESSION['error'] = "Error: " . $e->getMessage();
        header("Location: ../register.php");
        exit();
    }
}
?>