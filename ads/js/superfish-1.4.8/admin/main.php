<?php ob_start();
session_start();

if(isset($_SESSION['myusername']) == '')
header('location:index.php');
?>
<?php
include('../config.php');

if($_POST['suggest']){
//echo $_POST['suggest'];
$query = mysql_query("SELECT * FROM category WHERE newspaper_id = '".$_POST['suggest']."' AND parent_id != 0");
$result='';
while($data=mysql_fetch_assoc($query))
{
	$result.="<li>".$data['category_name']."</li>";
	}
	echo $result;
die;
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
<link rel="stylesheet" media="all" href="admin-style-inner.css"/>

</head>

<body>

<header>

<div class="logo"><a href="main.php"><img src="../img/logo.png"></a>

<div class="welcome">Welcome <?php echo $_SESSION['myusername']?> | <a href="Logout.php">Logout</a></div>
</div>
</header>

<section>

<!----------------------------------------------- Start Newspaper ----------------------------------------------->
<div class="newspaper">
<section class="pannel1">
<h1>Newspapers</h1>
<ul>
<?php

$query = mysql_query("SELECT * FROM newspapers WHERE status = 1");
while( $paper = mysql_fetch_array($query) )
{
?>

<li>
<img src="../<?php echo $paper['logo']?>" border="0" align="right"/><a href="category.php?id=<?= $paper['id']; ?>"><?php echo $paper['newspaper_name']?></a>


<?php
if(@$_POST ['submit'])
{
$file = $_FILES ['file'];
$name1 = $file ['name'];
$type = $file ['type'];
$size = $file ['size'];
$tmppath = $file ['tmp_name']; 
if($name1!="")
{
if(move_uploaded_file ($tmppath, '../newspaperimg/'.$name1))//image is a folder in which you will save image
{
$query="UPDATE newspapers set logo='newspaperimg/$name1' WHERE id=".$_POST['newspaper_id']."";
mysql_query ($query) or die ('could not updated:'.mysql_error());
header ("Location:main.php");
}
}
}
?>
<form name="form" class="upload-file" action="" method="post" enctype="multipart/form-data">
<input type="file" name="file" />
<input type="hidden" value="<?php echo $paper['id']?>" name="newspaper_id">
<input type="submit" name="submit" value="submit" /> 
</form>

</li>

<?php } 
ob_flush();
?>

</ul>
</section>

</div> 
<!----------------------------------------------- End Newspaper ----------------------------------------------->


</sction>

 
</html>
</body>