<?php
include('config.php');
$last_msg_id=isset($_GET['last_msg_id']);
$action=isset($_GET['action']);
$cat = base64_decode($_GET['id']);

if( $_POST['search-cities'] == '' ){
	header('location:index.php'); 
}
	
if($action <> "get")
{
?>
<?php include 'header.php' ?>


<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onclick="closehead();"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        	

          <div class="left-sec">
          <!-- Listing container -->
		  <div id="filter-container-category" class="cf" onClick="closeall();">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">分类广告</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
        
<?php
$c = '';
$n = '';
$g = '';
if($_POST['search-cities'])
{
foreach($_POST['search-cities'] as $cities)
{
	$c = $c.$cities.",";
}
}
if($_POST['search-news'])
{
foreach($_POST['search-news'] as $newsp)
{
$n = $n.$newsp.",";
}
}
if( $_POST['search-category'] )
				{
					//$atul=array();
//					/*print_r($_POST['search-category']);*/
//					
//			foreach($_POST['search-category'] as $id)
//			{
//			       $ides=mysql_fetch_assoc(mysql_query("select id from category where category_name='".$id."'"));
//				   $atul[]=$ides['id'];
//			}
		/*	print_r($atul);
			die	 ;*/  
			foreach($_POST['search-category'] as $newcat)	
			{
				//$g = $g.$O.",";
				$g = $g.$newcat.",";
			}
				}

$last_msg_id=$_GET['last_msg_id'];
//echo "SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id = '".$_GET['id']."' AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5";

//echo "SELECT * FROM ads WHERE category_id IN ( SELECT category_id FROM category_to_newspaper WHERE newspaper_id IN (".rtrim($n,",").") AND city IN (".rtrim($c,",").") ORDER BY id ASC LIMIT 3";
//
//exit();

//
//echo $_POST['search-category'];
//exit();

//echo "SELECT * FROM ads WHERE id > '$last_msg_id' AND category_id IN (".$_GET['category'].") AND city IN (".$_GET['city'].") ORDER BY id ASC LIMIT 5";
if($_POST['search-cities'] && $_POST['search-news'] && $_POST['search-category'])
{
	//echo "SELECT * FROM ads WHERE category_id IN (".rtrim($g,",").") AND city IN (".rtrim($c,",").") ORDER BY id ASC";
	//exit();
	
 $sql=mysql_query("SELECT * FROM ads WHERE category_id IN (".rtrim($g,",").") AND city IN (".rtrim($c,",").") ORDER BY id ASC");
}
if($_POST['search-cities'] && $_POST['search-news'] && !$_POST['search-category'])
{
 $sql=mysql_query("SELECT * FROM ads WHERE category_id IN ( SELECT category_id FROM category_to_newspaper WHERE newspaper_id IN (".rtrim($n,",").")) AND city IN (".rtrim($c,",").") ORDER BY id ASC");
}
if($_POST['search-cities'] && !$_POST['search-news'])
{
 $sql=mysql_query("SELECT * FROM ads WHERE city IN (".rtrim($c,",").") ORDER BY id ASC");
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
		//$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE category_id ='".$_GET['id']."' )");
		//
//		echo "SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE category_id = (SELECT category_id FROM ads WHERE id ='".$row['id']."' ) )";
//		exit();
		$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE category_id = (SELECT category_id FROM ads WHERE id ='".$row['id']."' ) )");
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


		  <div id="last_msg_loader"></div>
		  </div></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
        	<!--- end portfolio-content ---->
        
          
          
          <div class="right-sec">
          <?php include 'sidebar2.php'; ?>
          </div>
		  </div></div>
        	<!--- end portfolio-content ---->
          </div>
        
        
    </div>
    <!--- end wrapper ---->
<script>
last_msg_funtion1();
</script>    
<?php include 'footer.php' ?>
<?php } else {
echo '<div id="cl" style="display:block;">';
include('load_search_newspaper.php');		
echo '</div>';	} ?>	