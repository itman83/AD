<?php ob_start();
include('config.php');
include ('header.php'); 
session_start();
$_SESSION['random_id'] = '';
//LATEST Ads
$Lates_Ads = mysql_fetch_array(mysql_query("SELECT * FROM ads WHERE status=1 ORDER BY creation_time DESC LIMIT 0,1"));
 $Category_Name = mysql_fetch_array(mysql_query("SELECT category_name FROM category where id ='".$Lates_Ads['category_id']."'"));
							   
							   	$city=$Lates_Ads['city'];
							    $City_Name= mysql_fetch_array(mysql_query("SELECT city_name FROM cities where id ='".$city."'"));
								
								//$creation_time1=$result['creation_time'];
							    //$search3= mysql_fetch_array(mysql_query("SELECT * FROM ads where id ='".$creation_time1."'"));
								
								
								$Newspaper_Id = mysql_fetch_array(mysql_query("SELECT newspaper_id FROM category_to_newspaper WHERE category_id = '".$Lates_Ads['category_id']."'"));	

								
								
								$Newspaper_Name = mysql_fetch_array(mysql_query("SELECT newspaper_name FROM newspapers WHERE id = '".$Newspaper_Id['newspaper_id']."'"));
//LATEST Ads

$Total_Ads = mysql_fetch_array(mysql_query("SELECT COUNT(id) as total FROM ads WHERE status=1"));
?>
<script>
setInterval(function(){get_randon_ads()},6000);
function get_randon_ads()
{
$.post("get_random_ads.php",
			
			function(data){
				if (data != "") {
				
				document.getElementById('random').style.display='none';
			    document.getElementById('random').innerHTML='';
				
				$("#random").fadeIn(3000); 
				document.getElementById('random').innerHTML=data;
				}
				
			});	
}
</script>
<div class="wrapper1" onclick="closehead();">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
            	<div class="section1">
                <h1>Welcome to FA Classifieds</h1>
                <p>Free classified for Realestate, jobs, automobiles, electronics etc. </p>
                </div>
                
                <div class="section2">
                <h1>Total Ad Posted</h1>
                <p><?=$Total_Ads['total']?></p>
                </div>
            	
                <div id="random" class="section3">
                <h1><?=$Lates_Ads['ads_title']?></h1>
                <div class="city"><?=$City_Name['city_name']?></div>
                <div class="newspaper"><?=$Newspaper_Name['newspaper_name']?></div>
                <div class="cate"><?=$Category_Name['category_name']?></div>
                <div class="date"><?=$Lates_Ads['creation_time']?></div>
                
                </div>
                
				
		
                
                </div></div>
            </div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onclick="closehead();"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        		
				
				<!-- Filter container -->
		 		<div id="filter-container" class="cf">
                <?php $query = mysql_query("SELECT * FROM newspapers WHERE status = 1");
				while( $paper = mysql_fetch_array($query) )	{ ?>
		    	<figure class="web print">
				<figcaption>
				<div class="item-excerpt">
                <a href="newspaper.php?id=<?php echo base64_encode($paper['id']); ?>"><div class="item-excerpt-inner">
                <img src="<?php echo $paper['logo']; ?>" border="0" align="right"/>
                <h6 class="news-paper-name"><?php echo $paper['newspaper_name']; ?></h6>
                </div></a>
				<div class="classifiedd-news-category">
                <ul>
                <?php $data = mysql_query("SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id = '".$paper['id']."')");
				while( $category = mysql_fetch_array($data) ) { ?>
                <li><img src="<?=$category['logo']?>" style="margin-right:5px;" height="15px" width="15px" align="left" border="0"/><a class="ttxt" href="category.php?id=<?php echo base64_encode($category['id']); ?>"><?php echo $category['category_name']; ?></a></li>
                <?php } ?>
                </ul>
                </div></div>    
				</figcaption>
				</figure>
              	<?php } ?>
                   
              
		  </div><!-- ENDS Filter container -->
				
			</div>
        	<!--- end portfolio-content ---->
        
    </div>
    <!--- end wrapper ---->

<?php include 'footer.php' ?>