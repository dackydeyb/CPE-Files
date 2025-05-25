<?php
// Create connection
$conn = new mysqli('localhost', 'root', '', 'page2');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Array of table names
$tables = array("Students", "Faculty", "Courses", "Grades");

// Loop through each table and fetch data
foreach ($tables as $table) {
    $sql = "SELECT * FROM $table";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "<h2>$table</h2>";
        echo "<table><tr>";

        // Get field names
        while ($fieldinfo = $result->fetch_field()) {
            echo "<th>" . $fieldinfo->name . "</th>";
        }

        // Add Edit and Delete columns
        echo "<th>Edit</th>";
        echo "<th>Delete</th>";
        echo "</tr>";

        // Output data of each row
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            foreach ($row as $value) {
                echo "<td>" . $value . "</td>";
            }

            // Add Edit and Delete buttons
            echo "<td><button>Edit</button></td>";
            echo "<td><button>Delete</button></td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<h2>$table</h2>";
        echo "0 results";
    }
}

$conn->close();
?>
