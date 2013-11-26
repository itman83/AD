<div id="test" style="display:none;">
<?php
$last_msg_id=$_GET['last_msg_id'];
 $sql=mysql_query("SELECT * FROM ads WHERE id < '$last_msg_id' ORDER BY id DESC LIMIT 5");
 $last_msg_id="";

		while($row=mysql_fetch_array($sql))
		{
		$msgID= $row['id'];
		if( isset($_GET['id']) == $row['category_id'] )
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
		$date= $row['creation_time'];
		$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category WHERE id ='".isset($_GET['id'])."' )");	
$papername = mysql_fetch_array($name);
	?>
		
<div id="<?php echo $msgID; ?>"  align="left" class="message_box" >
<h1><?php echo $title; ?></h1> 
<p><?php echo $desc; ?></p> 
<span><?php echo $city['city_name']?> | <?php echo $date ?> | <?php echo $papername['newspaper_name']?></span>
</div>
		

<?php
}
?>
</div>