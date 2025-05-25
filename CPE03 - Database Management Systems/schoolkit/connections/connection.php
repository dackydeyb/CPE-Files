<?php

    function connection() {

        $servername = "localhost";
        $username = "root"; // default username for XAMPP
        $password = ""; // default password for XAMPP
        $dbname = "online_portal"; // your database name

        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        } else {
            return $conn;
        }

    }