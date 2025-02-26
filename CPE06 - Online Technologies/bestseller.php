<?php
session_start();

// Check if the user is logged in
if (isset($_SESSION['user_id'])) {
  echo "User ID: " . $_SESSION['user_id'];
} else {
  echo "User not logged in.";
}

include_once 'connection.php';

// Initialize $items as an empty array
$items = [];

$page = 'bestseller';
$sql = "SELECT * FROM items WHERE page = :page";
$stmt = $conn->prepare($sql);
$stmt->bindParam(':page', $page);
$stmt->execute();
$items = $stmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($items as $item) {
    // Display the item
}

// Initialize cart count
$cartCount = 0;

if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];
    $cartQuery = $conn->prepare("SELECT COUNT(*) FROM cart WHERE user_id = ?");
    $cartQuery->execute([$user_id]);
    $cartCount = $cartQuery->fetchColumn();
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Best Sellers</title>

  <link rel="stylesheet" href="CSS/bestseller.css" />
  <link rel="icon" type="image/png" href="./Sticker/March 7th_4.png">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Madimi+One&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
</head>
<body>
<audio id="bg-music" loop autoplay>
  <source src="./music/Koi_is_love.mp3" type="audio/mpeg">
  Your browser does not support the audio element.
</audio>
  <div id="left-animation" class="side-animation">
    <ul class="menu-list">
      <li><a href="CSSfinal.html">HOME</a></li>
      <li><a href="about.html">ABOUT ME</a></li>
      <li><a href="login.php">LOGIN</a></li>
      <li><a href="#">CONTACT ME</a></li>
      <li><a href="shop.php">SHOP NOW</a></li>
      <li><a href="cart.php">YOUR CART [<?php echo $cartCount; ?>]</a></li>
    </ul>
  </div>
  <div id="right-animation" class="side-animation"></div>
  
  <main>
    <header>
      <nav class="navbar">
        <ul class="nav-list">
          <li class="nav-item">
            <label class="hamburger">
              <input type="checkbox">
              <svg viewBox="0 0 32 32">
                <path class="line line-top-bottom" d="M27 10 13 10C10.8 10 9 8.2 9 6 9 3.5 10.8 2 13 2 15.2 2 17 3.8 17 6L17 26C17 28.2 18.8 30 21 30 23.2 30 25 28.2 25 26 25 23.8 23.2 22 21 22L7 22"></path>
                <path class="line" d="M7 16 27 16"></path>
              </svg>
              <span class="menu-text">MENU</span>
            </label>
          </li>
          <li class="nav-item" id="nav-title"><a href="CSSfinal.html">KAWAII KINGDOM</a></li>
          <li class="nav-item">
            <div class="nav-search-profile">
              <form action="submit">
                <div class="search-container">
                  <img src="Elements/search.png" alt="Search-Icon" id="search-icon">
                  <input type="text" placeholder="Search..." id="search-bar">
                </div>
              </form>
              <a href="login.php">
                <img src="Elements/profile.png" alt="Profile" id="profile-icon">
              </a>
                
            </div>
          </li>
        </ul>
      </nav>
    </header>
 
    <div class="header-title">
      <h1>- Best Sellers -</h1>
    </div>

  
    <div class="shop-container">
      <div class="left-panel">

        <!-- Sort by Price -->
        <div class="filter-sort">
          <div class="sort-title">Sort by Price</div>
          <div class="sort-options">
            <div class="cntr-rd">
              <input type="radio" id="price-low-high" name="sort-price" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="price-low-high" class="lbl">Low to High</label>
            </div>
            <div class="cntr-rd">
              <input type="radio" id="price-high-low" name="sort-price" class="hidden-xs-up">
              <label for="price-high-low" class="cbx-rd"></label>
              <label for="price-high-low" class="lbl">High to Low</label>
            </div>
          </div>
        </div>

        <!-- Filter by Type of Paper -->
        <div class="filter-paper">
          <div class="paper-title">Type of Paper</div>
          <div class="paper-options">
            <div class="cntr">
              <input type="radio" id="type-vinyl" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-vinyl" class="lbl">Vinyl</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-holographic" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-holographic" class="lbl">Holographic</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-glitter" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-glitter" class="lbl">Glitter</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-paper" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-paper" class="lbl">Paper</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-die-cut" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-die-cut" class="lbl">Die-Cut</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-decal" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-decal" class="lbl">Decal</label>
            </div>
            <div class="cntr">
              <input type="radio" id="type-static-cling" name="paper-type" class="hidden-xs-up">
              <label for="price-low-high" class="cbx-rd"></label>
              <label for="type-static-cling" class="lbl">Static-Cling</label>
            </div>
          </div>
        </div>

        <!-- Filter by Review Stars -->
        <div class="filter-review">
          <div class="review-title">Review</div>
          <div class="rating">
            <input value="5" name="rate" id="star5" type="radio">
            <label title="text" for="star5"></label>
            <input value="4" name="rate" id="star4" type="radio">
            <label title="text" for="star4"></label>
            <input value="3" name="rate" id="star3" type="radio" checked="">
            <label title="text" for="star3"></label>
            <input value="2" name="rate" id="star2" type="radio">
            <label title="text" for="star2"></label>
            <input value="1" name="rate" id="star1" type="radio">
            <label title="text" for="star1"></label>
          </div>
        </div>
      </div>

      <div class="right-panel">
      <div class="main-right-content">
          <?php foreach ($items as $item) : ?>
            <div class="card">
              <div class="card-img">
                <div class="img">
                  <img src="images/<?php echo htmlspecialchars($item['image']); ?>" alt="<?php echo htmlspecialchars($item['name']); ?>">
                </div>
              </div>
              <div class="card-title"><?php echo htmlspecialchars($item['name']); ?></div>
              <div class="card-subtitle"><?php echo htmlspecialchars($item['description']); ?></div>
              <hr class="card-divider">
              <div class="card-footer">
                <div class="card-price"><span>₱</span><?php echo htmlspecialchars($item['price']); ?></div>
                <form method="POST" action="add_to_cart.php" class="add-to-cart-form">
                  <input type="hidden" name="item_id" value="<?php echo htmlspecialchars($item['id']); ?>">
                  <input type="hidden" name="item_name" value="<?php echo htmlspecialchars($item['name']); ?>">
                  <input type="hidden" name="item_price" value="<?php echo htmlspecialchars($item['price']); ?>">
                  <button type="submit" class="card-btn">
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                      <path d="m397.78 316h-205.13a15 15 0 0 1 -14.65-11.67l-34.54-150.48a15 15 0 0 1 14.62-18.36h274.27a15 15 0 0 1 14.65 18.36l-34.6 150.48a15 15 0 0 1 -14.62 11.67zm-193.19-30h181.25l27.67-120.48h-236.6z"></path>
                      <path d="m222 450a57.48 57.48 0 1 1 57.48-57.48 57.54 57.54 0 0 1 -57.48 57.48zm0-84.95a27.48 27.48 0 1 0 27.48 27.47 27.5 27.5 0 0 0 -27.48-27.47z"></path>
                      <path d="m368.42 450a57.48 57.48 0 1 1 57.48-57.48 57.54 57.54 0 0 1 -57.48 57.48zm0-84.95a27.48 27.48 0 1 0 27.48 27.47 27.5 27.5 0 0 0 -27.48-27.47z"></path>
                      <path d="m158.08 165.49a15 15 0 0 1 -14.23-10.26l-25.71-77.23h-47.44a15 15 0 1 1 0-30h58.3a15 15 0 0 1 14.23 10.26l29.13 87.49a15 15 0 0 1 -14.23 19.74z"></path>
                    </svg>
                  </button>
                </form>
              </div>
            </div>
          <?php endforeach; ?>

        </div>

        <div class="pagination-container">
          <nav class="pagination-outer" aria-label="Page navigation">
              <ul class="pagination">
                  <li class="page-item">
                      <a href="#" class="page-link" aria-label="Previous">
                          <span aria-hidden="true">«</span>
                      </a>
                  </li>
                  <li class="page-item active"><a class="page-link" href="#">1</a></li>
                  <li class="page-item"><a class="page-link" href="#">2</a></li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item"><a class="page-link" href="#">4</a></li>
                  <li class="page-item"><a class="page-link" href="#">5</a></li>
                  <li class="page-item">
                      <a href="#" class="page-link" aria-label="Next">
                          <span aria-hidden="true">»</span>
                      </a>
                  </li>
              </ul>
          </nav>
        </div>

        <div class="close-notes-container" id="close-notes">
          <ul>
            <li class="sticker-care">
              <h3>Sticker Care</h3>
              <p>Keep your stickers looking fresh and fabulous by keeping them away from Mr. Sunshine and Ms. Moisture. A gentle pat with a dry cloth will keep their adhesive powers strong for a long, long time!</p>
            </li>
            <li class="terms-of-service" >
              <h3>Terms of Service</h3>
              <p>By visiting our website, you're agreeing to play by our rules – but don't worry, they're totally fair and fun! Every purchase is a party, and our terms of use make sure everyone has a blast.</p>
            </li>
            <li class="privacy-policy">
              <h3>Privacy Policy</h3>
              <p>Your privacy is our top priority, and we'll treat your personal info like a precious secret. Our detailed privacy policy outlines how we keep your deets safe and sound.</p>
            </li>
          </ul>
        </div>
      </div>

      

    </div>   
  
    <footer >
      <div class="footer-title">
        <h2 id="footer-title-h2">
          <a href="#" id="footer-title-link">KAWAII KINGDOM</a>
        </h2>
        <p id="footer-title-p">A Sticker Shop</p>
      </div>
    
      <ul class="footer-links">
        <li>
          <img id="furina" src="./Sticker/FurinaDance.gif" alt="furina-dance">
        </li>
        
        <li class="footer-column">
          <a href="#" id="link-back-to-top">BACK TO TOP</a>
          <a href="CSSfinal.html" id="link-home">HOME</a>
          <a href="login.php" id="link-login">LOGIN</a>
        </li>

        <li class="footer-column">
          <a href="shop.php" id="link-shop-all-stickers">SHOP ALL STICKERS</a>
          <a href="newarrivals.php" id="link-new-arrivals">NEW ARRIVALS</a>
          <a href="bestseller.php" id="link-best-sellers">BEST SELLERS</a>
        </li>

        <li class="footer-column">
          <a href="#" id="link-column-stickers">CUSTOM STICKERS</a>
          <a href="about.html" id="link-about-us">ABOUT US</a>
          <a href="#" id="link-how-made">HOW IT'S MADE</a>
        </li>

        <li class="footer-column">
          <a href="#close-notes" id="link-sticker-care">STICKER CARE</a>
          <a href="#" id="link-order-tracking">ORDER TRACKING</a>
          <a href="#" id="link-returns">RETURNS & EXCHANGES</a>
        </li>

        <li class="footer-column">
          <a href="#close-notes" id="link-terms">TERMS OF SERVICE</a>
          <a href="#close-notes" id="link-privacy">PRIVACY POLICY</a>
          <a href="#" id="link-contact">CONTACT US</a>
        </li>

        <li class="footer-column">
          <a href="https://www.facebook.com/dackydeyb"><img src="./Elements/footer-facebook.png" alt="Facebook Link"></a>
          <a href="https://twitter.com/dackydeyb"><img src="./Elements/footer-twitter.png" alt="Twitter Profile"></a>
          <a href="https://github.com/dackydeyb"><img src="./Elements/footer-github.png" alt="Github Profile"></a>
          <a href="https://www.reddit.com/user/DaYousoro/"><img src="./Elements/footer-reddit.png" alt="Reddit Link"></a>
          <a href="#"><img src="./Elements/footer-gmail.png" alt="Email"></a>
        </li>
      </ul>

      <p id="credits">© Dave Jhared G. Paduada BSCpE II - IF</p>

    </footer>
  </main>

<script src="JS/bestseller.js"></script>
</body>
</html>