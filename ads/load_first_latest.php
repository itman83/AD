<?php
$sql=mysql_query("SELECT * FROM ads ORDER BY id DESC LIMIT 10");
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
		$cat= mysql_fetch_array(mysql_query("SELECT category_name FROM category WHERE id = '".$row['category_id']."'"));
		$date= $row['creation_time'];
		$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE id ='".isset($_GET['id'])."' )");	
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
