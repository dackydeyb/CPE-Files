<?php
include 'connection.php';

if (isset($_POST['delete'])) {
    $id = $_POST['id'];

    // Fetch the image file name
    $sql = "SELECT image FROM items WHERE id = :id";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':id', $id);
    $stmt->execute();
    $item = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($item) {
        $image = $item['image'];
        $imagePath = 'images/' . $image;

        // Delete the image file from the images folder
        if (file_exists($imagePath)) {
            unlink($imagePath);
        }

        // Delete the record from the database
        $sql = "DELETE FROM items WHERE id = :id";
        $stmt = $conn->prepare($sql);
        $stmt->bindParam(':id', $id);

        if ($stmt->execute()) {
            echo "Item deleted successfully.";
        } else {
            echo "Error deleting item.";
        }
    } else {
        echo "Item not found.";
    }

    if ($stmt->execute()) {
        echo "Item deleted successfully.";
        header("Location: item_add.php");
        exit;
    } else {
        echo "Error deleting item.";
    }
}
?>