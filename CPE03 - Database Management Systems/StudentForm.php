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
if(isset($_POST['firstName']) && isset($_POST['middleInitial']) && isset($_POST['lastName']) && isset($_POST['studentNo']) && isset($_POST['curricularProgram']) && isset($_POST['email'])) {
    // Retrieve form data
    $firstName = $_POST['firstName'];
    $middleInitial = $_POST['middleInitial'];
    $lastName = $_POST['lastName'];
    $studentNo = $_POST['studentNo'];
    $curricularProgram = $_POST['curricularProgram'];
    $email = $_POST['email'];

    // Check if user already exists
    $check = $conn->prepare("SELECT * FROM Students WHERE Student_No = ?");
    $check->bind_param("s", $studentNo);
    $check->execute();
    $check->store_result();

    if(isset($_POST['register'])) {
        if($check->num_rows > 0) {
            echo "<script>alert('User already exists');</script>";
        } else {
            // Insert new user into the database
            $sql = $conn->prepare("INSERT INTO Students (First_Name, Middle_Initial, Last_Name, Student_No, Curricular_Program, Email) VALUES (?, ?, ?, ?, ?, ?)");
            $sql->bind_param("ssssss", $firstName, $middleInitial, $lastName, $studentNo, $curricularProgram, $email);
            if($sql->execute()) {
                echo "<script>alert('User registered successfully'); window.location.href='Student Form.html';</script>";
            } else {
                echo "Error: " . $sql->error;
            }
        }
    } else if(isset($_POST['update'])) {
        // Update existing user in the database
        $sql = $conn->prepare("UPDATE Students SET First_Name = ?, Middle_Initial = ?, Last_Name = ?, Curricular_Program = ?, Email = ? WHERE Student_No = ?");
        $sql->bind_param("ssssss", $firstName, $middleInitial, $lastName, $curricularProgram, $email, $studentNo);
        if($sql->execute()) {
            echo "<script>alert('User updated successfully'); window.location.href='Student Form.html';</script>";
        } else {
            echo "Error: " . $sql->error;
        }
    } else if(isset($_POST['delete'])) {
        // Delete existing user from the database
        $sql = $conn->prepare("DELETE FROM Students WHERE Student_No = ?");
        $sql->bind_param("s", $studentNo);
        if($sql->execute()) {
            echo "<script>alert('User deleted successfully'); window.location.href='Student Form.html';</script>";
        } else {
            echo "Error: " . $sql->error;
        }
    }
} else {
    echo "No form data received";
}

$conn->close();
?>
