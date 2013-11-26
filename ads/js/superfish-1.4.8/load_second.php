
<div id="test" style="display:none;">
<?php
$last_msg_id=$_GET['last_msg_id'];
$categories = '';
$cids = mysql_query("SELECT id FROM category WHERE id ='".$_GET['id']."' OR parent_id='".$_GET['id']."'");
while($data = mysql_fetch_array($cids))
{
$categories = $categories.$data['id'].",";	
}
//echo "SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id = '".$_GET['id']."' AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5";
if( $_GET['city'] != '' )
{
	
 $sql=mysql_query("SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id IN (".rtrim($categories,",").") AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5");
}
else
{
$sql=mysql_query("SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id IN (".rtrim($categories,",").")  ORDER BY id ASC LIMIT 5");	
}
 $last_msg_id="";

		while($row=mysql_fetch_array($sql))
		{
		$msgID= $row['id'];
		if( $_GET['id'] == $row['category_id'] )
		{
		$title= $row['ads_title'];
		}
		else
		{
		$sub_name = mysql_fetch_array(mysql_query("SELECT category_name FROM category WHERE id = '".$row['category_id']."'")); 	
		$title= $sub_name['category_name'];	
		}
		$desc= $row['ads_desc'];
		$city= mysql_fetch_array(mysql_query("SELECT city_name FROM cities WHERE id = '".$row['city']."'"));
		$cat= mysql_fetch_array(mysql_query("SELECT category_name FROM category WHERE id = '".$row['category_id']."'"));
		$date= $row['creation_time'];
		$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category WHERE id ='".$_GET['id']."' )");	
$papername = mysql_fetch_array($name);
	?>
		
		<div id="<?php echo $msgID; ?>"  align="left" class="message_box" >
<h1><?php echo $title; ?></h1> 
<p><?php echo $desc; ?></p> 
<span><div class="city"><?php echo $city['city_name']?></div><div class="newspaper"><?php echo $papername['newspaper_name'] ?></div><div class="cate"><?php echo $cat['category_name'] ?></div><div class="date"><?php echo $date ?></div></span>
</div>
		

<?php
}
?>
</div>
