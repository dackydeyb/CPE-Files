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
if(isset($_POST['studentID']) && isset($_POST['grades']) && isset($_POST['facultyID'])) {
    // Retrieve form data
    $studentID = $_POST['studentID'];
    $grades = $_POST['grades']; // This should be an array of grades
    $facultyID = $_POST['facultyID']; // This should be an array of faculty IDs

    // Check if the lengths of the grades array and the facultyID array are the same
    if(count($grades) != count($facultyID)) {
        echo "Error: The number of grades and faculty IDs must be the same";
        exit();
    }

    // Insert each grade into the database
    for($i = 0; $i < count($grades); $i++) {
        $stmt = $conn->prepare("INSERT INTO Grades (Student_ID, Grade, Faculty_ID) VALUES (?, ?, ?)");
        $stmt->bind_param("iii", $studentID, $grades[$i], $facultyID[$i]);
        $stmt->execute();
    }

    echo "<script>alert('Grades added successfully'); window.location.href='Professor Form.html';</script>";
} else {
    echo "No form data received";
}

$conn->close();
?>
