<?php
include 'connection.php';

if (isset($_POST['update'])) {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    $page = $_POST['page'];

    // Check if a new image was uploaded
    if ($_FILES['image']['name']) {
        $image = $_FILES['image']['name'];
        $target = "images/" . basename($image);

        // Move the uploaded file to the images directory
        if (move_uploaded_file($_FILES['image']['tmp_name'], $target)) {
            $sql = "UPDATE items SET image = :image, name = :name, description = :description, price = :price, page = :page WHERE id = :id";
        } else {
            echo "Error moving uploaded file.";
            exit;
        }
    } else {
        $sql = "UPDATE items SET name = :name, description = :description, price = :price, page = :page WHERE id = :id";
    }

    $stmt = $conn->prepare($sql);
    if ($_FILES['image']['name']) {
        $stmt->bindParam(':image', $image);
    }
    $stmt->bindParam(':name', $name);
    $stmt->bindParam(':description', $description);
    $stmt->bindParam(':price', $price);
    $stmt->bindParam(':page', $page);
    $stmt->bindParam(':id', $id);

    if ($stmt->execute()) {
        echo "Item updated successfully.";
        header("Location: item_add.php");
        exit();
    } else {
        echo "Error updating item.";
    }
}
?>
