<?php
session_start();
include 'connection.php';

// Check if item_id and user_id are set
if (isset($_POST['item_id']) && isset($_SESSION['user_id'])) {
    
    $item_id = $_POST['item_id'];
    $user_id = $_SESSION['user_id'];

    // Debugging: Print values
    error_log("user_id: $user_id, item_id: $item_id");

    try {
        $query = $conn->prepare("DELETE FROM cart WHERE user_id = ? AND item_id = ?");
        $query->execute([$user_id, $item_id]);

        if ($query->rowCount() > 0) {
            echo 'success';
        } else {
            echo 'failure: no rows affected';
        }
    } catch (Exception $e) {
        echo 'failure: ' . $e->getMessage();
    }
} else {
    echo 'failure: missing parameters';
}
?>
