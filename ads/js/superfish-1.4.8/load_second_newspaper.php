
<div id="test" style="display:none;">
<?php
$last_msg_id=$_GET['last_msg_id'];
//echo "SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id = '".$_GET['id']."' AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5";

if( $_GET['category'] != '0' )
{
//echo "SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id IN (".$_GET['category'].") AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5";
 $sql=mysql_query("SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id IN (".$_GET['category'].") AND status=1 ORDER BY id ASC LIMIT 3");
 
}

 $last_msg_id="";

		while($row=mysql_fetch_array($sql))
		{
		$msgID= $row['id'];
		$title= $row['ads_title'];
		$desc= $row['ads_desc'];
		$city= mysql_fetch_array(mysql_query("SELECT city_name FROM cities WHERE id = '".$row['city']."'"));
		$cat= mysql_fetch_array(mysql_query("SELECT category_name FROM category WHERE id = '".$row['category_id']."'"));
		$date= $row['creation_time'];
		$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE id ='".$_GET['id']."' )");	
$papername = mysql_fetch_array($name);
	?>
		
		<div id="<?php echo $msgID; ?>"  align="left" class="message_box" >
<h1><?php echo $title; ?>

<span style="float:right;">
<!-- Atul popup testing starts-->
<dd class="fav"> <a name="<?=$desc?>  |@凡人凡事|  www.cnfanads.com" onclick="vpb_share_box(this.name);"><img border="0" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/share.png"></a></dd>
<!-- Atul popup testing end-->
            
</span>
</h1> 
<p><?php echo $desc; ?></p> 
<span><div class="city"><?php echo $city['city_name']?></div><div class="newspaper"><?php echo $papername['newspaper_name'] ?></div><div class="cate"><?php echo $cat['category_name'] ?></div><div class="date"><?php echo $date ?></div></span>
</div>
		

<?php
}
?>
</div>
