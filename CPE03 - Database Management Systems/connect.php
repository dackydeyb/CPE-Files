<?php
// Database connection
$servername = "localhost";
$username = "root"; // default username for XAMPP
$password = ""; // default password for XAMPP
$dbname = "online portal"; // your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if form data is set
if(isset($_POST['studentID']) && isset($_POST['password'])) {
    // Retrieve form data
    $studentID = $_POST['studentID'];
    $entered_password = $_POST['password'];

    // Prepare SQL statement to prevent SQL injection
    $sql = $conn->prepare("SELECT * FROM student_users WHERE studentID = ?");
    $sql->bind_param("s", $studentID);
    $sql->execute();
    $result = $sql->get_result();

    // Check if user exists
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashed_password = $row['password']; // retrieve the hashed password from the database

        if (password_verify($entered_password, $hashed_password)) {
            header("Location: Student Form.html"); // Redirect to Student Form.html
            exit;
        } else {
            echo "<script>alert('Incorrect password'); window.location.href='Database Act Proposal.html';</script>";
        }
    } else {
        echo "<script>alert('User not found'); window.location.href='Database Act Proposal.html';</script>";
    }
} else {
    echo "No form data received";
}

$conn->close();
?>
