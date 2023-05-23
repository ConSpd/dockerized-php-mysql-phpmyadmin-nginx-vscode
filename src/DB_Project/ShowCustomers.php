<!DOCTYPE html>
<html>
    <head>
        <title>Customers</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <style>
        td,th{
            padding:8px;
        }
    </style>
    <?php
        $host = "mysql";
        $username = "root";
        $passwd = "password";
        $dbname = "general_insurance";
        $conn = mysqli_connect($host, $username, $passwd, $dbname);
        $val = $_POST['products'];
    ?>
    <body>
        <h2>
        <p>Στοιχεία ατόμων που χρησιμοποιούν την ασφάλεια
            <?php echo $val?></p>
        </h2>
    <?php
        $query = "select c_name,address,c_phone,afm,doy from customer inner join contract
                 on customer.customer_no = contract.customer_no
                 inner join product on contract.product_no = product.product_no
                 where prod_type = '".$val."'";
        $result = mysqli_query($conn,$query);
        if(!$result){
            echo "Problem parsing Database".mysqli_error($conn);
        }else{?>
            <table border='1px'>
                <tr>
                    <th>Name</th>
                    <th>Address</th>
                    <th>Phone</th>
                    <th>AFM</th>
                    <th>DOY</th>
                </tr>
                <?php
                while($data = mysqli_fetch_array($result,MYSQLI_BOTH)){
                    echo "<tr align='center'>";
                    echo "<i><td>".$data[0]."</td></i>";
                    echo "<td>".$data[1]."</td>";
                    echo "<td>".$data[2]."</td>";
                    echo "<td>".$data[3]."</td>";
                    echo "<td>".$data[4]."</td>";
                    echo "</tr>";
                }?>
            </table><?php
        }
    ?>
    <br><br>
        <form method="get" action="index.php">
            <input type="submit" value="Front Page">
        </form>
    </body>
</html>
