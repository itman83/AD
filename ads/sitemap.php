<?php
include('config.php');
?>
<?php include 'header.php' ?>


	<div class="wrapper1" onClick="closehead();">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
				


            	<h4 class="fa">网站地图</h4>
            </div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onClick="closehead();"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">        	
				
				
				
				<!--<ul id="filter-buttons">
				 
				
				<!-- Filter container -->
		 
          

          
          
          <!-- Listing container -->
		  <div id="filter-container-category" class="cf">
                
		    	<figure class="web print"> 
						<figcaption>
										
                          <div class="item-excerpt">
                          	<div class="item-excerpt-inner">
                            	
                          
                                
                                <h6 class="news-paper-name">分类广告：房屋出租 搬家 婚庆 招工 教育 生活服务等</h6>
                            </div>
                            
                            
                            
                            
						  	<div id="clearall" class="classifiedd-news-category3">
                            
							<div class="classifiedd-news-category-sitemap">

                             <ul>
                             <h1>主菜单</h1>
                                <?php
				$menu = mysql_query("SELECT * FROM menu WHERE status = 1");	
				while( $menu1 = mysql_fetch_array($menu) )
				{
				?>
                <li><a href="<?=$menu1['menu_url']?>"><?=$menu1['menu_name']?></a></li>
                
                 <?php } ?>
                                
                                </ul>
                                
                                
                                <?php
				$query = mysql_query("SELECT * FROM newspapers WHERE status = 1");
				while( $paper = mysql_fetch_array($query) )
				{
				?>
                
                
                
                <ul>
                <h1><a href="newspaper.php?id=<?=base64_encode($paper['id'])?>"><?=$paper['newspaper_name']?></a></h1>
                           <?php
						   $data = mysql_query("SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id = '".$paper['id']."')");
				while( $category = mysql_fetch_array($data) )
				{
						   ?>
                                	<li><a class="ttxt" href="category.php?id=<?=base64_encode($category['id'])?>"><?=$category['category_name']?></a></li>
                                    <?php } ?>
                                                                   </ul>
                                                                   <?php } ?>
                 
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
<script type="text/javascript">
<!--
var Accordion1 = new Spry.Widget.Accordion("Accordion1");
//-->
</script>
<?php include 'footer.php' ?>
