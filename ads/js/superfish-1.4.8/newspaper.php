<?php
include('config.php');
$last_msg_id=isset($_GET['last_msg_id']);
$action=isset($_GET['action']);
$cat = base64_decode($_GET['id']);
if($action <> "get")
{
?>
<?php include 'header.php' ?>
	<div class="wrapper1" onClick="closehead();">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
				<?php $query = mysql_fetch_array(mysql_query("SELECT * FROM newspapers WHERE id = '".base64_decode($_GET['id'])."'")); ?>
			<h4 class="fa">Home &raquo; <?php echo $query['newspaper_name']?></h4>
            </div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onclick="closehead();">
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        	
         <div id="filter-container-category" class="cf" onClick="closeall();">
          <figure class="web print">
		  <figcaption>
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">Select Category</h6></div>
		  <div class="classifiedd-news-category2">
          <div class="classifiedd-news-category2-list">
          <form name="select_cat" method="post">
          <?php	$query = mysql_fetch_array(mysql_query("SELECT * FROM newspapers WHERE id = (SELECT newspaper_id FROM category_to_newspaper WHERE id = '".base64_decode($_GET['id'])."') AND status=1")); ?>
          <ul>
          <li><input  onClick="check_all_cat(this);" type="checkbox" checked value="">SELECT ALL</li>
          <?php $data = mysql_query("SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id = '".$query['id']."')");
				while( $category = mysql_fetch_array($data) ) { ?>
          <li><input onClick="last_msg_funtion1();" name="cat_name[]" checked type="checkbox" value="<?php echo $category['id']?>"><?php echo $category['category_name']?></li>
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
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <?php include('load_first_newspaper.php'); ?>
		  <div id="last_msg_loader"></div>
		  </div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
        	</div><!--- end portfolio-content ---->
        
          
          
          <div class="right-sec">
          <?php include 'sidebar.php'; ?>
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
include('load_second_newspaper.php');		
echo '</div>';	} ?>	