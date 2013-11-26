<?php ob_start();
include('config.php');
session_start();
if( $_SESSION['random_id'] == '' || $_SESSION['random_id'] == 10 )
{
	$_SESSION['random_id'] = 1;
}
else
{
$_SESSION['random_id'] = $_SESSION['random_id'] + 1;	
}

$Lates_Ads = mysql_fetch_array(mysql_query("SELECT * FROM ads WHERE status=1 ORDER BY creation_time DESC LIMIT ".$_SESSION['random_id'].",1"));
 $Category_Name = mysql_fetch_array(mysql_query("SELECT category_name FROM category where id ='".$Lates_Ads['category_id']."'"));
							   
							   	$city=$Lates_Ads['city'];
							    $City_Name= mysql_fetch_array(mysql_query("SELECT city_name FROM cities where id ='".$city."'"));
								
								//$creation_time1=$result['creation_time'];
							    //$search3= mysql_fetch_array(mysql_query("SELECT * FROM ads where id ='".$creation_time1."'"));
								
								
								$Newspaper_Id = mysql_fetch_array(mysql_query("SELECT newspaper_id FROM category_to_newspaper WHERE category_id = '".$Lates_Ads['category_id']."'"));	

								
								
								$Newspaper_Name = mysql_fetch_array(mysql_query("SELECT newspaper_name FROM newspapers WHERE id = '".$Newspaper_Id['newspaper_id']."'"));

echo '<h1>'.$Lates_Ads['ads_title'].'</h1>
                <div class="city">'.$City_Name['city_name'].'</div>
                <div class="newspaper">'.$Newspaper_Name['newspaper_name'].'</div>
                <div class="cate">'.$Category_Name['category_name'].'</div>
                <div class="date">'.$Lates_Ads['creation_time'].'</div>';
				
?>
