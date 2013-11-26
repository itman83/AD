<?php
session_start();
error_reporting(0);
if(isset($_SESSION['myusername']) == '')
header('location:index.php');
include('../config.php');
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
<link rel="stylesheet" media="all" href="admin-style-inner.css"/>

</head>

<script>

					function valid()

					{
						
						var name = document.getElementById('name').value;
						if(document.frm.name.value=='Create By Default Category' || document.frm.name.value==null)

					{

					alert("Enter Category Name");

					return(false);

					}
					
					else{
 $.post(

{name: name},
function(data) {
if( data == '0' )
{

Recaptcha.reload();
}
if( data == '1' )
{

}
}
); 
 return(false);
}

}
						
						
</script>

<body>

<header>

<div class="logo"><a href="index.php"><img src="../img/logo.png"></a>

<div class="welcome">Welcome <?=$_SESSION['myusername']?> | <a href="Logout.php">Logout</a></div>
</div>
</header>
<?php
$query = mysql_fetch_array(mysql_query("SELECT * FROM newspapers WHERE id = '".base64_decode($_GET['id'])."'"));
?>
<section>
<h1><?php echo $query['newspaper_name']?></h1>
<div class="newspaper1">
<section class="pannel1">
<h1>Category</h1>

<ul>


<?php
						   $data = mysql_query("SELECT * FROM category WHERE newspaper_id = '".$query['id']."'");
				while( $category = mysql_fetch_array($data) )
				{
						   ?>                        
<li><input name="" type="checkbox" value=""><?php echo $category['category_name']?></li>
    <?php } ?>                       
</ul>

</section>
</div>


<div class="newspaper2">
<form name="frm" method="post" action="" class="default-cat" onSubmit="return valid()">
<?php

$host="localhost"; // Host name
$username="root"; // Mysql username
$password=""; // Mysql password
$db_name="cnfaads"; // Database name
$tbl_name="default_cat"; // Table name

// Connect to server and select database.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

// Get values from form
$name=$_POST['name'];

// Insert data into mysql
$sql="INSERT INTO $tbl_name(d_cat)VALUES('$name')";
$result=mysql_query($sql);

// if successfully insert data into database, displays message "Successful".
if($result){

}


?>


<input type="text" id="name" name="name" value="Create By Default Category" onBlur="if(this.value == '') { this.value='Create By Default Category'}" onFocus="if (this.value == 'Create By Default Category') {this.value=''}"> <input type="submit" name="Submit" value="Create">
</form>

<section class="pannel1">
<h1>By Default Category</h1>

<ul>
<?php
				$dcat = mysql_query("SELECT * FROM default_cat WHERE status = 1");	
				while( $dcat1 = mysql_fetch_array($dcat) )
				{
				?>
                <li><input name="" type="checkbox" value=""><?php echo $dcat1['d_cat']?> <span><a href="">Edit</a> | <a href="#">Delete</a></span></li>
                
                 <?php } ?>

</ul>

</section>
</div>


</section>

</body>
</html>