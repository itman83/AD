<div class="red-search-section">
        	<form action="search.php" method="post" name="Query1" id="Query1" onSubmit="return valid_search();">
       		<div class="what-are-you-searching">
            	<input id="search-txt" class="what-are-you-searching-for" name="search-txt" value="这里总有你需要的" size="16" type="text" onBlur="if (this.value == ''){this.value = '这里总有你需要的'; }" onFocus="if (this.value == '这里总有你需要的') {this.value = ''; }" />
            </div>
            <div class="all-newspaper">
            
            
            <a onClick="return showHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide1();">所有城市</p>
                <div id="showHideDiv1" style="display:none;">
                <ul>
                <?php
				$city = mysql_query("SELECT * FROM cities where status=1");	
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
                <p class="all-news-paper-content" onClick="return showHide();" >所有报刊</p>
                <div id="showHideDiv" style="display:none;">
                <ul id="all_newspapers"></ul>
                </div>
                
            </div>
            <div class="all-cities">
            	<a onClick="return showHide2();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide2();">所有栏目</p>
                
                <div id="showHideDiv2" style="display:none;">
                <ul id="all_categories">
                
                
                </ul>
                 </div>
            </div>
            
            <input type="submit" class="search"/>
            </form>
        </div>