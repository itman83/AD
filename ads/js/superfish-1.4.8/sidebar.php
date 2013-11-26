<!-- Listing container -->
<form action="side-search.php" name="sidesearch" id="sidesearch" method="post" onSubmit="return valid_side_search();">
		  <div id="filter-container-category" class="cf">
          <figure class="web print"> 
		  <figcaption> 
		  <div class="item-excerpt">
          <div class="item-excerpt-inner"><h6 class="news-paper-name">Search By City</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
           <div class="side-newspaper"><a onClick="return cityHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return cityHide1();">All Cities</p>
                <div id="showHidecity1" style="display:none;">
                <ul>
                <?php $city = mysql_query("SELECT * FROM cities");	
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
          <div class="item-excerpt-inner"><h6 class="news-paper-name">Search By Newspaper</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper">
            	<a onClick="return newsHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return newsHide();" >All Newspaper</p>
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
          <div class="item-excerpt-inner"><h6 class="news-paper-name">Search By Category</h6></div>
		  <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
          <div class="side-newspaper">
            	<a onClick="return catHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="side-news-paper-content" onClick="return catHide();" >All Categories</p>
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
		  <div id="clearall" class="classifiedd-news-category2 alignright" style="padding:0px"><input type="submit" class="search-btn" value="Search" name="side-search" /></div></div>
          </figcaption> 
		  </figure> 
		  </div><!-- ENDS Filter Listing -->
          </form>