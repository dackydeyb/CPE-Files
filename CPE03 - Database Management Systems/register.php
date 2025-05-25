<?php
// Database connection
$servername = "localhost";
$username = "root"; // default username for XAMPP
$password = ""; // default password for XAMPP
$dbname = "online_portal"; // your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if form data is set
if(isset($_POST['studentID']) && isset($_POST['password'])) {
    // Retrieve form data
    $studentID = $_POST['studentID'];
    $password = $_POST['password']; // this should be a secure password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Insert new user into the database
    $sql = $conn->prepare("INSERT INTO student_users (studentID, password) VALUES (?, ?)");
    $sql->bind_param("ss", $studentID, $hashed_password);
    if($sql->execute()) {
        echo "<script>alert('User registered successfully'); window.location.href='http://localhost/schoolkit/login.php';</script>";
    } else {
        echo "Error: " . $sql->error;
    }
} else {
    echo "No form data received";
}

$conn->close();
?>
