<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

$user_id = $_SESSION['user_id'];

// Database connection
include 'connection.php';

// Fetch cart items
$query = $conn->prepare("SELECT cart.id, items.image, items.name, items.price FROM cart INNER JOIN items ON cart.item_id = items.id WHERE cart.user_id = ?");
$query->execute([$user_id]);
$cart_items = $query->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html>

<head>
    <title>Cart</title>
    <link rel="icon" type="image/png" href="./Sticker/March 7th_4.png">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th,
        td {
            border: 1px solid black;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        .total-price {
            font-weight: bold;
        }

        .btn {
            padding: 5px 10px;
            margin: 5px;
            cursor: pointer;
        }

        .btn-clear {
            background-color: #f44336;
            color: white;
            border: none;
        }

        .btn-checkout,
        .btn-continue {
            background-color: #4CAF50;
            color: white;
            border: none;
        }
    </style>
    </style>
</head>

<body>
    <h1>Your Cart</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Image</th>
                <th>Name</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Clear</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($cart_items as $item) : ?>
                <tr>
                    <td><?php echo htmlspecialchars($item['id']); ?></td>
                    <td><img src="images/<?php echo htmlspecialchars($item['image']); ?>" alt="<?php echo htmlspecialchars($item['name']); ?>" width="50"></td>
                    <td><?php echo htmlspecialchars($item['name']); ?></td>
                    <td><?php echo htmlspecialchars($item['price']); ?></td>
                    <td><input type="number" value="1" min="1"></td>
                    <td class="total-price">₱<?php echo htmlspecialchars($item['price']); ?></td>
                    <td><button class="btn btn-clear" data-item-id="<?php echo htmlspecialchars($item['id']); ?>">Clear</button></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <button class="btn btn-continue" onclick="window.location.href = 'shop.php';">Continue Shopping</button>
    <div>
        Grand Total: ₱<span id="grand-total">0.00</span>
    </div>
    <button class="btn btn-checkout">Checkout</button>


    <script>
        document.querySelector('.btn-checkout').addEventListener('click', function() {
            window.location.href = '/stickershop/Elements/gcash.jpg';
        });
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('tbody tr');
            const grandTotalElement = document.getElementById('grand-total');

            function calculateGrandTotal() {
                let grandTotal = 0;
                rows.forEach(row => {
                    const quantityInput = row.querySelector('input[type="number"]');
                    const price = parseFloat(row.querySelector('td:nth-child(4)').innerText);
                    const totalPriceElement = row.querySelector('.total-price');
                    const totalPrice = price * quantityInput.value;
                    totalPriceElement.innerText = '₱' + totalPrice.toFixed(2);
                    grandTotal += totalPrice;
                });
                grandTotalElement.innerText = grandTotal.toFixed(2);
            }

            rows.forEach(row => {
                const quantityInput = row.querySelector('input[type="number"]');
                const clearButton = row.querySelector('.btn-clear');
                quantityInput.addEventListener('input', calculateGrandTotal);
                clearButton.addEventListener('click', function() {
                    const itemId = this.getAttribute('data-item-id');
                    fetch('remove_from_cart.php', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'item_id=' + itemId
                        }).then(response => response.text())
                        .then(responseText => {
                            if (responseText.trim() === 'success') {
                                row.remove();
                                calculateGrandTotal();
                            } else {
                                alert('Failed to remove item from cart: ' + responseText);
                            }
                        }).catch(error => {
                            alert('Failed to remove item from cart: ' + error.message);
                        });
                });
            });

            calculateGrandTotal();
        });
    </script>
</body>

</html>