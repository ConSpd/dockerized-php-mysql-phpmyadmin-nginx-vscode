<!DOCTYPE html>
<html>
    <head>
        <title>Select Product</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <?php
        $host = "mysql";
        $username = "root";
        $passwd = "password";
        $dbname = "general_insurance";
        $conn = mysqli_connect($host, $username, $passwd, $dbname);
    ?>
    <body>
        <h2>Επιλογή ασφάλειας</h2>
        <?php
            if(!$conn){
                echo "Failure Connecting ".mysqli_connect_error();
                exit();
            }
            $query = "select prod_type from product";
            $result = mysqli_query($conn,$query);
        ?>
        <br>
        <form action="ShowCustomers.php" method="POST">
            <label for="Products">Choose a product</label>
            <select name="products">
                <?php
                    while($data = mysqli_fetch_array($result,MYSQLI_BOTH)){
                        echo "<option>$data[0]</option>";
                    }
                ?>
            </select>
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
