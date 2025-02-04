<?php
$host = 'localhost';
$dbname = 'inventory'; 
$username = 'root';
$password = ''; 
$port = 3307; // Custom port


try {
    // Create a PDO connection
    //$pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo = new PDO("mysql:host=$host;port=$port;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>