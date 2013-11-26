<!-- Listing container -->
<form action="search.php" name="modifysearch" id="modifysearch" method="post" onSubmit="return valid_modify_search();">
			
           <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">选择关键词</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
           <div class="what-are-you-searching-side">
<input id="search-txt-side" class="what-are-you-searching-for-modify" type="text" onfocus="if (this.value == '这里总有你需要的') {this.value = ''; }" onblur="if (this.value == ''){this.value = '这里总有你需要的'; }" size="16" value="<?php echo $text ?>" name="search-txt">
</div>
		  <div id="last_msg_loader"></div>
		  </div></div>
          </figcaption> 
		  </figure> 
          </div> 
            

		  <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">选择城市</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
           <div class="side-newspaper-search">
                <div id="showHidecity1-search">
                <ul>
                <?php $city = mysql_query("SELECT * FROM cities where status=1");	
				while( $cities = mysql_fetch_array($city) )	{
				$checked_city = 0;	
				if( isset ($_POST['search-cities']) && $_POST['search-cities'] )
				{
				foreach($_POST['search-cities'] as $N)	
				{
				if($N == $cities['id'])
				$checked_city = 1;
				}
				}
					?>
                <li><input <?php if($checked_city==1){ ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-cities[]" type="checkbox" value="<?php echo $cities['id']?>"><?php echo $cities['city_name']?></li>
                <?php } ?>
            	</ul>
            </div>
		  </div></div>
          </figcaption> 
		  </figure> 
          </div>
          
          <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">选择报纸</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper-search">
          <div id="showHidecity1-search">
           <ul>
            <?php $news = mysql_query("SELECT * FROM newspapers");	
			while( $newsp = mysql_fetch_array($news) )	{ 
			$checked_news = 0;	
				if( isset($_POST['search-news']) &&  $_POST['search-news'] )
				{
				foreach($_POST['search-news'] as $M)	
				{
				if($M == $newsp['id'])
				$checked_news = 1;
				}
				}			
			?>
            <li><input <?php if($checked_news==1){ ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-news[]" type="checkbox" value="<?php echo $newsp['id']?>"><?php echo $newsp['newspaper_name']?></li>
            <?php } ?>
           </ul>
          </div>
		  </div></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          
          <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">选择栏目</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper-search">
          <div id="showHidecity1-search">
           <ul>
            <?php $cat = mysql_query("SELECT * FROM category");	$atul=array();
if( isset ($_POST['search-category']) && $_POST['search-category'] )
				{
foreach($_POST['search-category'] as $id)
			{
				//print_r($id);
//					exit();		
                               // echo "select id from category where category_name='".$id."'"; exit;
			       $ides=mysql_fetch_assoc(mysql_query("select id from category where id='".$id."'"));
				   $atul[]=$ides['id'];
				// print_r($ides['id']);
//				 exit();
			}}
			while( $catg = mysql_fetch_array($cat) ) { 
			$checked_cat = 0;	
				if( isset ($_POST['search-category']) && $_POST['search-category'] )
				{
					
				//	print_r($_POST['search-category']);
//					exit();
			
//		echo "<pre>";	print_r($atul);
		//	die;  
				foreach($atul as $O)	
				{  
				if($O == $catg['id'])
				{  $checked_cat = 1;
				}
                                 }
				}
			?>
            <li><input <?php if($checked_cat==1){ ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-category[]" type="checkbox" value="<?php echo $catg['id'];?>"><?php echo $catg['category_name']?></li>
            <?php } ?>
           </ul>
          </div>
		  </div></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          
          <div id="filter-container-category" class="cf">
          <figure class="web print box-sh-none"> 
		  <figcaption> 
		  <div class="item-excerpt">
		  <div id="clearall" class="classifiedd-news-category2 alignright" style="padding:0px"><input type="submit" class="search-btn" value="修改搜索" name="modifysearch" /></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          </form>