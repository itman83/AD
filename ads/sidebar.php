<!-- Listing container -->
<form action="side-search.php" name="sidesearch" id="sidesearch" method="post" onSubmit="return valid_side_search();">
		  <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">搜索城市</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
           <div class="side-newspaper"><a onClick="return cityHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return cityHide1();">所有城市</p>
                <div id="showHidecity1" style="display:none;">
                <ul>
                <?php $city = mysql_query("SELECT * FROM cities where status=1");	
				while( $cities = mysql_fetch_array($city) )	{ ?>
                <li><input onClick="get_cetagory_list_side();" name="search-cities[]" type="checkbox" value="<?php echo $cities['id']?>"><?php echo $cities['city_name']?></li>
                <?php } ?>
            	</ul>
                </div>
            </div>
		  </div></div>
          </figcaption> 
		  </figure> 
          </div>
          
          <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">搜索报刊</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper">
            	<a onClick="return newsHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return newsHide();" >所有报刊</p>
                <div id="showHidenews" style="display:none;">
                <ul id="all_newspapers_side"></ul>
                </div>
		  </div></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          
          
          <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">搜索栏目</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper">
            	<a onClick="return catHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return catHide();" >所有栏目</p>
                <div id="showHidecat" style="display:none;">
                <ul id="all_categories_side"></ul>
                </div>
		  </div></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          
          <div id="filter-container-category" class="cf">
          <figure class="web print box-sh-none"> 
		  <figcaption> 
		  <div class="item-excerpt">
		  <div id="clearall" class="classifiedd-news-category2 alignright" style="padding:0px"><input type="submit" class="search-btn" value="搜索" name="side-search" /></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          </form>