<!DOCTYPE html>

<html>
    <head>
        <title>Products</title>
    </head>
    
    <?php
        $host = "mysql";
        $username = "root";
        $passwd = "password";
        $dbname = "general_insurance";
        $query = "select * from product";
        
    ?>
    <style>
    td,th{
        padding: 10px;
    }
    </style>
    
    <body>
        <?php
            $conn = mysqli_connect($host, $username, $passwd, $dbname);
            if(!$conn){
                echo "Failure Connecting ".mysqli_connect_error();
                exit();
            }
            $result = mysqli_query($conn, $query);
        ?>
        <table border="1px">
            <tr>
                <th>Category</th>
                <th>Cost_per_Year</th>
                <th>Minimum_time</th>
            </tr>
            <?php
                if($result){
                    while($row = mysqli_fetch_array($result,MYSQLI_NUM)){
                        echo "<tr align=center><td><i>".$row[1]."</i></td>";
                        echo "<td>".$row[2]."</td>";
                        echo "<td>".$row[3]."</td><br>";
                    }
                }
            ?>
        </table>
        <br><br>
        <form method="get" action="index.php">
            <input type="submit" value="Front Page">
        </form>
    </body>
</html>