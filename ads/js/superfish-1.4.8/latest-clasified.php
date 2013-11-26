<?php
include('config.php');


$last_msg_id=isset($_GET['last_msg_id']);
$action=isset($_GET['action']);

if($action <> "get")
{
?>
<?php include 'header.php' ?>
	<div class="wrapper1">
    	<!--- start fa-classified ---->
    		<div class="fa-classified"><h4 class="fa">Latest Classified</h4></div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        	
          <!-- Listing container -->
		  <div id="filter-container-category" class="cf">
                
		    	<figure class="web print">
						<figcaption> 
										
                          <div class="item-excerpt">
                          	<div class="item-excerpt-inner"><h6 class="news-paper-name">Ads</h6></div>
						  	<div id="clearall" class="classifiedd-news-category2">
                            	<?php include('load_first_latest.php'); ?>
<div id="last_msg_loader"></div>
</div>
</div>
</div>
</figcaption>
</figure>
		  </div><!-- ENDS Filter Listing -->
				
			</div>
        	<!--- end portfolio-content ---->
        
    </div>
    <!--- end wrapper ---->
</section>
<!--- end section ---->
<!--- start section ---->
<?php include 'footer.php'; ?>
<?php
}
else
{
 
include('load_second_latest.php');		
	
		}
		?>	