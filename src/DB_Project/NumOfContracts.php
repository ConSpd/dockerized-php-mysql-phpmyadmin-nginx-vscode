<!DOCTYPE html>
<html>
    <head>
        <title>NumOfContracts</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <style>
        td,th{
            padding:5px;
        }
    </style>
    <?php
        $host = "mysql";
        $username = "root";
        $dbname = "general_insurance";
        $passwd = "password";
        $conn = mysqli_connect($host, $username, $passwd, $dbname);
        $date = $_POST['date'];
        $afm = $_POST['afm'];
    ?>
    <body>
        <p><h2>Results</h2></p>
        <hr>
        <?php
            if(!$conn){
                echo "Connecting Failure ".mysqli_connect_error();
                exit();
            }
            $query = "call get_insurances(".$afm.",'".$date."')";
            $result = mysqli_query($conn,$query);
            $data = mysqli_fetch_array($result,MYSQLI_NUM);
        ?>
        <table border="1px">
            <tr align="center">
                <th>Amount of Contracts</th>
                <th>Total Price</th>
            </tr>
            <tr align="center">
                <?php 
                    echo "<td>".$data[0]."</td>";
                    echo "<td>".$data[1]."</td>";
                ?>
            </tr>
        </table>
        <br><br>
        <form method="get" action="index.php">
            <input type="submit" value="Front Page">
        </form>
    </body>
</html>