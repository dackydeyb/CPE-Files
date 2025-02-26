<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    echo "Redirecting to login.php...";
    header('Location: login.php');
    exit();
} else {
    echo "User ID in session: " . $_SESSION['user_id'];
}

if (!isset($_POST['item_id'])) {
    echo "Error: Item ID is not set.";
    exit();
} else {
    echo "Item ID: " . $_POST['item_id'];
}

require 'connection.php';

$item_id = $_POST['item_id'];
$user_id = $_SESSION['user_id'];

try {
    $stmt = $conn->prepare("INSERT INTO cart (user_id, item_id) VALUES (:user_id, :item_id)");
    $stmt->bindParam(':user_id', $user_id, PDO::PARAM_INT);
    $stmt->bindParam(':item_id', $item_id, PDO::PARAM_INT);
    $stmt->execute();

    echo "Item successfully added to cart.";
    header('Location: shop.php?message=Item added to cart');
    exit();
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}

$conn = null;
?>
