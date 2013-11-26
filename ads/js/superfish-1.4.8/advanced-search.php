<div class="red-search-section">
        	<form action="search.php" method="post" name="Query1" id="Query1" onSubmit="return valid_search();">
       		<div class="what-are-you-searching">
            	<input id="search-txt" class="what-are-you-searching-for" name="search-txt" value="What are you searching for?" size="16" type="text" onBlur="if (this.value == ''){this.value = 'What are you searching for?'; }" onFocus="if (this.value == 'What are you searching for?') {this.value = ''; }" />
            </div>
            <div class="all-newspaper">
            
            
            <a onClick="return showHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide1();">All Cities</p>
                <div id="showHideDiv1" style="display:none;">
                <ul>
                <?php
				$city = mysql_query("SELECT * FROM cities");	
				while( $cities = mysql_fetch_array($city) )
				{
				?>
                <li><input onClick="get_cetagory_list();" name="search-cities[]" type="checkbox" value="<?php echo $cities['id']?>"><?php echo $cities['city_name']?></li>
                
                 <?php } ?>
            
            	 </ul>
                </div>
            </div>
				
            
            <div class="all-categories">
            	<a onClick="return showHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide();" >All Newspaper</p>
                <div id="showHideDiv" style="display:none;">
                <ul id="all_newspapers"></ul>
                </div>
                
            </div>
            <div class="all-cities">
            	<a onClick="return showHide2();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide2();">All Categories</p>
                
                <div id="showHideDiv2" style="display:none;">
                <ul id="all_categories">
                
                
                </ul>
                 </div>
            </div>
            
            <input type="submit" class="search"/>
            </form>
        </div>