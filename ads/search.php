<?php

include('config.php');


	
include 'header.php' ?>

	<div class="wrapper1" onclick="closehead();">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
             <?php $text = $_POST['search-txt']; ?>
			<h4 class="fa">搜索 &raquo; <?php echo $text ?></h4>
            </div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper" onclick="closehead();"> 
        <!--- start portfolio-content ---->
        <div id="portfolio-content" class="cf">
		<!-- Filter container -->
        <!-- Listing container -->
        <div class="left-sec">
		<div id="filter-container-category" class="cf" onClick="closeall();">
        <figure class="web print">  
		<figcaption> 
		<div class="item-excerpt">
        <div class="item-excerpt-inner">
       
        <h6 class="news-paper-name">分类广告</h6>
        </div>
		<div id="clearall" class="classifiedd-news-category2">
        <?php             $city_ids = '';
                          if(isset($_POST['search-cities'])) { 
                          //print_r($_POST);
                          $city = $_POST['search-cities'];
			 
			  foreach($city as $cityid)
				{
						$city_ids = $city_ids.$cityid.",";	
						}}
						$news_ids = '';
						if(  isset($_POST['search-news']) &&  $_POST['search-news'] != '' )
						{
						   $news = $_POST['search-news'];
						   foreach($news as $newsid)
						{
						$news_ids = $news_ids.$newsid.",";	
						}
						}
						$cat_ids = '';
						if(   isset($_POST['search-category']) && $_POST['search-category'] != '' )
						{
						   $cat           = $_POST['search-category'];
						   
						    foreach($cat as $catid)
						{
						$cat_ids = $cat_ids."'".$catid."',";	
						}
						}
					 if(  !isset($_POST['search-news'] )  &&  !isset($_POST['search-category']) && !isset($_POST['search-cities']) )
						{  
					
					//echo "SELECT * FROM ads WHERE (ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR (category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC"; exit;
//					exit();
//echo "SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR  (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC";					
						 $search = mysql_query("SELECT * FROM ads WHERE (ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR (category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC");	
					
						}         
					else if(  !isset($_POST['search-news'] )  &&  !isset($_POST['search-category']) && isset($_POST['search-cities']) )
						{  
					
					//echo "SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND ads_desc LIKE '%".$text."%') OR  (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC";
//					exit();
//echo "SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR  (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC";					
						 $search = mysql_query("SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR  (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%')) ORDER BY creation_time DESC");	
					
						}
						else if( isset($_POST['search-news']) != '' && isset($_POST['search-category']) == '' && isset($_POST['search-cities']) !='')
						{ 
						 $search = mysql_query("SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category_to_newspaper WHERE newspaper_id IN(".rtrim($news_ids,",")."))  AND (ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%')) OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))");
						}
						else if( isset($_POST['search-news']) == '' && isset($_POST['search-category']) != '' && isset($_POST['search-cities']) != '')
						{
						  $search = mysql_query("SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name IN (".rtrim($cat_ids,",").")) AND ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%') OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))");
						}
						
						else
						{  
						
					//echo "SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category_to_newspaper WHERE newspaper_id IN(".rtrim($news_ids,",").") AND ads_desc LIKE '%".$text."%')) OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))"; exit();	
						
				//	Old Query
				//"SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category_to_newspaper WHERE newspaper_id IN(".rtrim($news_ids,",").") AND category_name IN (".rtrim($cat_ids,",").")) AND ads_desc LIKE '%".$text."%') OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))"	
						//echo "SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category_to_newspaper WHERE newspaper_id IN(".rtrim($news_ids,",").") AND category_id IN(".trim($cat_ids,",").")) AND (ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%')) OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))";
					   $search = mysql_query("SELECT * FROM ads WHERE (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category_to_newspaper WHERE newspaper_id IN(".rtrim($news_ids,",").") AND category_id IN(".trim($cat_ids,",").")) AND (ads_desc LIKE '%".$text."%' OR ads_title LIKE '%".$text."%')) OR (city IN (".rtrim($city_ids,",").") AND category_id IN(SELECT id FROM category WHERE category_name LIKE '%".$text."%'))"); 
						}
						
						if( mysql_num_rows($search) > 0 )
						{
						   while($result = mysql_fetch_array($search))
						   {
							   
							   $cat_id=$result['category_id'];
							   
							   $search1= mysql_fetch_array(mysql_query("SELECT * FROM category where id ='".$cat_id."'"));
							   
							   	$city=$result['city'];
							    $search2= mysql_fetch_array(mysql_query("SELECT * FROM cities where id ='".$city."'"));
								
								$creation_time1=$result['creation_time'];
							    $search3= mysql_fetch_array(mysql_query("SELECT * FROM ads where id ='".$creation_time1."'"));
								
								
								$search4 = mysql_fetch_array(mysql_query("SELECT newspaper_id FROM category_to_newspaper WHERE id = '".$cat_id."'"));	

								
								
								$search5 = mysql_fetch_array(mysql_query("SELECT newspaper_name FROM newspapers WHERE id = '".$search4['newspaper_id']."'"));
$title=$result['ads_title'];
//$Share = '<span style="float:right;"><a href="javascript:var _t = encodeURI("'.$title.'");var _url = encodeURIComponent(document.location);var _appkey = encodeURI("27a537299f8b443280c1117e5d1b1b08");var _pic = encodeURI('');var _site = encodeURI("http://204.197.244.110/~cnfanews/cnfa-ads/v3/");var _u = "http://v.t.qq.com/share/share.php?url="+_url+"&appkey="+_appkey+"&site="+_site+"&pic="+_pic+"&title="+_t;window.open( _u,"_blank", "width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no" );void(0);" title="ÌÚÑ¶Î¢²©"><img src="img/share-6.png" height="30px" width="30px" border="0"></a><a href="javascript:(function(){window.open("http://v.t.sina.com.cn/share/share.php?appkey=3229244048&ralateUid=1916997175&title="+encodeURIComponent("'.$title.'")+"&url="+encodeURIComponent("http://204.197.244.110/~cnfanews/cnfa-ads/v3/")+"&source="+encodeURIComponent("·²ÎÅ·²ÊÂ")+"&sourceUrl="+encodeURIComponent("http://204.197.244.110/~cnfanews/cnfa-ads/v3/"),"_blank","width=450,height=400");})()" title="�?ÂÀËÎ¢²©"><img height="30px" width="30px" src="img/share-1.png" border="0"></a></span>';
							   
echo '<div class="message_box"><h1>'.$result['ads_title'].' '.' <span style="float:right;"><dd class="fav"><a name="@凡人凡事 | www.cnfanads.com | '.$result['ads_desc'].'" onclick="vpb_share_box(this.name);"><img border="0" src="img/share.png"></a></span></h1>
	  <p>'.$result['ads_desc'].'</p><span>
	  <div class="city">'.$search2['city_name'].'</div>
	  <div class="newspaper">'.$search5['newspaper_name'].'</div>
	  <div class="cate">'.$search1['category_name'].'</div>
	  <div class="date">'.$creation_time1=$result['creation_time'].'</div></span></div>'; ?>
       <?php } } else {  echo '<div class="message_box"><h1>对不起，没有您所要的信息</h1></div>';  } ?>
      

        </div></div>            
         
		</figcaption>    
		</figure>     
		  </div><!-- ENDS Filter Listing -->
</div> 
        	<!--- end portfolio-content ---->
        
    <!--- end wrapper ---->
       <div class="right-sec">
          <?php include 'search-sidebar.php'; ?>
          </div>
    </div></div>
    	  </div>
</section>
<!--- end section ---->
<!--- start section ---->
<?php include 'footer.php' ?>
