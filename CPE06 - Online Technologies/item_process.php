<?php
include 'connection.php';

if (isset($_POST['add'])) {
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $page = $_POST['page'];
    $image = $_FILES['image']['name'];
    $target = "images/" . basename($image);

    // Move the uploaded file to the images directory
    if (move_uploaded_file($_FILES['image']['tmp_name'], $target)) {
        $sql = "INSERT INTO items (name, description, price, image, page) VALUES (:name, :description, :price, :image, :page)";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':price', $price);
        $stmt->bindParam(':image', $image);
        $stmt->bindParam(':page', $page);

        if ($stmt->execute()) {
            echo "Item added successfully.";
            header("Location: item_add.php");
            exit();
        } else {
            echo "Error adding item.";
        }
    } else {
        echo "Error uploading image.";
    }
}
?>
