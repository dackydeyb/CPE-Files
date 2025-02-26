<?php
// item_add.php
session_start();

// Redirect to login page if not logged in
if (!isset($_SESSION['user'])) {
    header('Location: login.php');
    exit;
}
?>

<!DOCTYPE html>
<html>

<head>
    <title>Add Item</title>
    <link rel="icon" type="image/png" href="./Sticker/March 7th_4.png">
    <style>
        .container {
            width: 50%;
            margin: auto;
            font-family: Arial, sans-serif;
            padding-top: 20px;
        }

        #itemadd {
            border: 2px solid #000;
            border-radius: 10px;
            padding: 20px;
            background-color: #f9f9f9;
        }

        form label {
            font-size: 18px;
            display: block;
            margin-bottom: 10px;
        }

        form input[type="text"],
        form input[type="number"],
        form input[type="file"],
        form textarea {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 20px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form textarea {
            height: 100px;
        }

        .radio-buttons {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .radio-buttons label {
            font-size: 18px;
        }

        .buttons {
            display: flex;
            justify-content: space-around;
        }

        .buttons input {
            padding: 10px 20px;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .buttons input[type="submit"] {
            background-color: #4CAF50;
            color: white;
        }

        .buttons input[type="reset"] {
            background-color: #f44336;
            color: white;
        }

        hr {
            margin: 20px 0;
        }

        #searchInput {
            width: calc(100% - 22px);
            padding: 10px;
            font-size: 16px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 18px;
            text-align: left;
        }

        table,
        th,
        td {
            border: 1px solid black;
        }

        th,
        td {
            padding: 12px;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .table {
            overflow-x: auto;
            padding-left: 120px;
            padding-right: 120px;
        }
    </style>
    <script>
        function searchItems() {
            var input, filter, table, tr, td, i, j, txtValue;
            input = document.getElementById("searchInput");
            filter = input.value.toLowerCase();
            table = document.getElementById("itemsTable");
            tr = table.getElementsByTagName("tr");

            for (i = 1; i < tr.length; i++) {
                tr[i].style.display = "none";
                td = tr[i].getElementsByTagName("td");
                for (j = 0; j < td.length; j++) {
                    if (td[j]) {
                        txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                            break;
                        }
                    }
                }
            }
        }

        function sortTable(n) {
            var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            table = document.getElementById("itemsTable");
            switching = true;
            dir = "asc";

            while (switching) {
                switching = false;
                rows = table.rows;
                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[n];
                    y = rows[i + 1].getElementsByTagName("TD")[n];
                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }
                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }
    </script>
</head>

<body>
    <div class="container">
        <a href="logout.php">Log Out</a>
        <form id="itemadd" action="item_process.php" method="post" enctype="multipart/form-data">
            <label for="image">Image:</label>
            <input type="file" name="image" id="image" required><br>

            <label for="name">Name:</label>
            <input type="text" name="name" id="name" required><br>

            <label for="description">Description:</label>
            <textarea name="description" id="description" required></textarea><br>

            <label for="price">Price:</label>
            <input type="number" step="0.01" name="price" id="price" required><br>

            <div class="radio-buttons">
                <input type="radio" name="page" value="shop" id="shop" required>
                <label for="shop">Shop</label>
                <input type="radio" name="page" value="bestseller" id="bestseller" required>
                <label for="bestseller">Bestseller</label>
                <input type="radio" name="page" value="newarrivals" id="newarrivals" required>
                <label for="newarrivals">New Arrivals</label>
            </div>

            <div class="buttons">
                <input type="reset" value="Clear">
                <input type="submit" name="add" value="Add Item">
            </div>
        </form>

        <hr>

        <input type="text" id="searchInput" onkeyup="searchItems()" placeholder="Search for items..">

        <?php
        include 'connection.php';

        $sql = "SELECT * FROM items";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $items = $stmt->fetchAll(PDO::FETCH_ASSOC);
        ?>
    </div>

    <div class="table">
        <table id="itemsTable">
            <tr>
                <th onclick="sortTable(0)">Image</th>
                <th onclick="sortTable(1)">Name</th>
                <th onclick="sortTable(2)">Description</th>
                <th onclick="sortTable(3)">Price</th>
                <th onclick="sortTable(4)">Page</th>
                <th>Actions</th>
            </tr>
            <?php foreach ($items as $item) : ?>
                <tr>
                    <td><img src="images/<?php echo htmlspecialchars($item['image']); ?>" alt="<?php echo htmlspecialchars($item['name']); ?>" style="width:100px;"></td>
                    <td><?php echo htmlspecialchars($item['name']); ?></td>
                    <td><?php echo htmlspecialchars($item['description']); ?></td>
                    <td><?php echo htmlspecialchars($item['price']); ?></td>
                    <td><?php echo htmlspecialchars($item['page']); ?></td>
                    <td>
                        <form action="item_update.php" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<?php echo $item['id']; ?>">
                            <input type="submit" name="update" value="Update">
                        </form>
                        <form action="item_delete.php" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<?php echo $item['id']; ?>">
                            <input type="submit" name="delete" value="Delete" onclick="return confirm('Are you sure you want to delete this item?');">
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>

</body>

</html>
