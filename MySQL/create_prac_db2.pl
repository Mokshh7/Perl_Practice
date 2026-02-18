use strict;
use warnings;
use DBI;

# -------------------------------
# STEP 1: MySQL Connection Details
# -------------------------------
my $host     = "localhost";
my $user     = "root";
my $password = "";

# First connect WITHOUT selecting a database
my $dsn = "DBI:mysql:;host=$host";

my $dbh = DBI->connect(
    $dsn,
    $user,
    $password,
    {
        RaiseError => 1,
        AutoCommit => 1,
        mysql_enable_utf8 => 1,
    }
) or die "Database connection failed: $DBI::errstr";

print "Connected to MySQL Server successfully!\n";

# -------------------------------
# STEP 2: Create Database
# -------------------------------
my $db_name = "sql_practice_db";

$dbh->do("DROP DATABASE IF EXISTS $db_name");
$dbh->do("CREATE DATABASE $db_name");
print "Database '$db_name' created successfully!\n";

# -------------------------------
# STEP 3: Select Database
# -------------------------------
$dbh->do("USE $db_name");
print "Using database '$db_name'\n";

# -------------------------------
# STEP 4: Create Tables
# -------------------------------

# USERS table
$dbh->do("
    CREATE TABLE users (
        user_id INT AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        email VARCHAR(100) NOT NULL UNIQUE,
        password VARCHAR(100) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
");

print "Table 'users' created.\n";

# PRODUCTS table
$dbh->do("
    CREATE TABLE products (
        product_id INT AUTO_INCREMENT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        category VARCHAR(50),
        price DECIMAL(10,2) NOT NULL,
        stock INT DEFAULT 0
    )
");

print "Table 'products' created.\n";

# ORDERS table
$dbh->do("
    CREATE TABLE orders (
        order_id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        total_amount DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
    )
");

print "Table 'orders' created.\n";

# ORDER_ITEMS table
$dbh->do("
    CREATE TABLE order_items (
        item_id INT AUTO_INCREMENT PRIMARY KEY,
        order_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL,
        price_each DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
        ON DELETE CASCADE,
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE
    )
");

print "Table 'order_items' created.\n";

# -------------------------------
# STEP 5: Insert Sample Data
# -------------------------------

# Insert Users

$dbh->do('
    INSERT INTO users (username, email, password)
    VALUES
    ("moksh", "moksh@gmail.com", "moksh123"),
    ("rahul", "rahul@gmail.com", "rahul123"),
    ("simran", "simran@gmail.com", "simran123")
');


print "Sample users inserted.\n";

# Insert Products
$dbh->do("
    INSERT INTO products (product_name, category, price, stock)
    VALUES
    ('Rolex Submariner', 'Luxury Watch', 850000.00, 5),
    ('Casio G-Shock', 'Sports Watch', 12000.00, 50),
    ('Omega Seamaster', 'Luxury Watch', 650000.00, 8),
    ('Apple Watch Series 9', 'Smart Watch', 45000.00, 25),
    ('Titan Neo', 'Classic Watch', 6000.00, 100)
");

print "Sample products inserted.\n";

# Insert Orders
$dbh->do("
    INSERT INTO orders (user_id, total_amount)
    VALUES
    (1, 862000.00),
    (2, 57000.00)
");

print "Sample orders inserted.\n";

# Insert Order Items
$dbh->do("
    INSERT INTO order_items (order_id, product_id, quantity, price_each)
    VALUES
    (1, 1, 1, 850000.00),
    (1, 2, 1, 12000.00),
    (2, 4, 1, 45000.00),
    (2, 5, 2, 6000.00)
");

print "Sample order items inserted.\n";

# -------------------------------
# STEP 6: Done
# -------------------------------
print "\nDatabase setup completed successfully!\n";
print "Now you can practice SQL on database: $db_name\n";

$dbh->disconnect;
