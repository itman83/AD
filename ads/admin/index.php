<?php ob_start();
session_start();
if(isset($_SESSION['myusername']) != '' )
{
header('location:main.php');	
}
?>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie10 lt-ie9 lt-ie8 ie7" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie10 lt-ie9 ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]>   <html class="no-js lt-ie10 ie9" lang="en"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->	<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<meta name=viewport content="width=device-width, initial-scale=1.0, minimum-scale=1.0 maximum-scale=1.0">
<title>CNFA News Ads | Admin</title>
<link rel="stylesheet" media="all" href="admin-style.css"/>

</head>

<body>

<header>
<div class="logo"><a href="../index.php"><img src="../img/logo.png"></a></div>

</header>

<section>

<div class="account-login">
<div class="heading">Account Login</div>
<form name="form1" method="post" action="" class="form-login" onSubmit="return valid()">

<?php

ob_start();
$host="localhost"; // Host name
$username="root"; // Mysql username
$password="09936e96"; // Mysql password
$db_name="cnfanews_cnfa-ads-v2"; // Database name
$tbl_name="members"; // Table name

// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
if(isset($_POST['Submit']))
{
// username and password sent from form
$myusername=$_POST['myusername'];
$mypassword=$_POST['mypassword'];

// To protect MySQL injection (more detail about MySQL injection)
$myusername = stripslashes($myusername);
$mypassword = stripslashes($mypassword);
$myusername = mysql_real_escape_string($myusername);
$mypassword = mysql_real_escape_string($mypassword);

$sql="SELECT * FROM $tbl_name WHERE username='$myusername' and password='$mypassword'";
$result=mysql_query($sql);

// Mysql_num_row is counting table row
$count=mysql_num_rows($result);

// If result matched $myusername and $mypassword, table row must be 1 row

if($count==1){
session_start();
// Register $myusername, $mypassword and redirect to file "login_success.php"
$_SESSION['myusername'] = $myusername;
$_SESSION['mypassword'] = $mypassword;
header("location:main.php");
}
else {
echo "<div class='msg'>Wrong Username or Password</div>";
}
}
?>

<input name="myusername" type="text" id="myusername" placeholder="Username">
<input name="mypassword" type="password" id="mypassword" placeholder="Password">
<input type="submit" name="Submit" value="Login">

</form>


</div>

</section>

</body>
</html>


