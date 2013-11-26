<?php
include('config.php');
$last_msg_id=isset($_GET['last_msg_id']);
$action=isset($_GET['action']);
$cat = base64_decode($_GET['id']);
if($action <> "get")
{
?>
<?php include 'header.php' ?>
	<div class="wrapper1" onclick="closehead();">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
				<?php
$name = mysql_query("SELECT newspaper_name FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE id ='".base64_decode($_GET['id'])."' )");	
$papername = mysql_fetch_array($name);

$category = mysql_query("SELECT category_name FROM category WHERE id = '".base64_decode($_GET['id'])."'");	
$cat_name = mysql_fetch_array($category);

?>
     <h4 class="fa"><?php echo $papername['newspaper_name']; ?> &raquo; <?php echo $cat_name['category_name']; ?></h4>
     </div></div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onclick="closehead();"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        	
		<!-- Filter container -->
		<div id="filter-container-category" class="cf" onClick="closeall();">
        <figure class="web print">
		<figcaption>
		<div class="item-excerpt">
        <div class="item-excerpt-inner"><h6 class="news-paper-name">Select Category</h6></div>
		<div class="classifiedd-news-category1">
        <div class="classifiedd-news-category1-list">
        <form name="select_cat" method="post">
  <?php	$query_new = mysql_fetch_array(mysql_query("SELECT * FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE id = '".base64_decode($_GET['id'])."')")); ?>
          <ul>
          <li><input  onClick="check_all_cat(this);" type="checkbox" value="">SELECT ALL</li>
          <?php $data_new = mysql_query("SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id = '".$query_new['id']."')");
				while( $category_new = mysql_fetch_array($data_new) ) { ?>
          <li><input <?php if( base64_decode($_GET['id']) == $category_new['id'] ) { ?>checked<?php } ?> onClick="last_msg_funtion1();" name="cat_name[]" type="checkbox" value="<?php echo $category_new['id']?>"><?php echo $category_new['category_name']?></li>
          <?php } ?>
          </ul>
          </form>         	
        </div></div></div>
        </figcaption>
		</figure>
        </div><!-- ENDS Filter container --> 
          
          <div class="left-sec" onClick="closeall();">
          <!-- Listing container -->
		  <div id="filter-container-category" class="cf">
          <figure class="web print">
		  <figcaption>
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">Ads</h6></div>
		  <div id="clearall" class="classifiedd-news-category2">
          <?php include('load_first.php'); ?>
		  <div id="last_msg_loader"></div>
		  </div></div>
          </figcaption>
		  </figure>
		  </div><!-- ENDS Filter Listing -->
		  </div>
        	<!--- end portfolio-content ---->
          
    <!--- end wrapper ---->
    
    <div class="right-sec">
          <?php include 'sidebar.php'; ?>
          </div>
    </div></div>
    	  </div>
    
</section>
<script>
last_msg_funtion1();
</script>
<!--- end section ---->
<!--- start section ---->
<?php include 'footer.php' ?>
<?php } else {
echo '<div id="cl" style="display:block;">';
include('load_second.php');		
echo '</div>';
} ?>	