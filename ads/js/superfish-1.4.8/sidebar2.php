<?php $checked_city = 0;
      $checked_news = 0;
      $checked_cat = 0; ?>
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
                                    <?php
                                    $city = mysql_query("SELECT * FROM cities");
                                    while ($cities = mysql_fetch_array($city)) {
                                        if (isset($_POST['search-cities']) && $_POST['search-cities']) {
                                            $checked_city = 0;
                                            foreach ($_POST['search-cities'] as $N) {
                                                if ($N == $cities['id']) {
                                                    $checked_city = 1;
                                                }
                                            }
                                        }
                                        ?>
                                        <li><input <?php if ($checked_city == 1) { ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-cities[]" type="checkbox" value="<?php echo $cities['id'] ?>"><?php echo $cities['city_name'] ?></li>
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
                                <ul>
                                    <?php
                                    $news = mysql_query("SELECT * FROM newspapers");
                                    while ($newsp = mysql_fetch_array($news)) {
                                        $checked_news = 0;
                                        if (isset($_POST['search-news']) && $_POST['search-news']) {
                                            foreach ($_POST['search-news'] as $M) {
                                                if ($M == $newsp['id'])
                                                    $checked_news = 1;
                                            }
                                        }
                                        ?>
                                        <li><input <?php if ($checked_news == 1) { ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-news[]" type="checkbox" value="<?php echo $newsp['id'] ?>"><?php echo $newsp['newspaper_name'] ?></li>
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
                    <div class="item-excerpt-inner"><h6 class="news-paper-name">Search By Category</h6></div>
                    <div id="clearall" class="classifiedd-news-category2" style=" padding:0px">
                        <div class="side-newspaper">
                            <a onClick="return catHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                            <p class="side-news-paper-content" onClick="return catHide();" >All Categories</p>
                            <div id="showHidecat" style="display:none;">
                                <ul>
                                    <?php
                                    $cat = mysql_query("SELECT * FROM category");
                                    $atul = array();
                                    if (isset($_POST['search-category']) && $_POST['search-category']) {
                                        foreach ($_POST['search-category'] as $id) {
                                            //print_r($id);
//					exit();		
                                            // echo "select id from category where category_name='".$id."'"; exit;
                                            $ides = mysql_fetch_assoc(mysql_query("select id from category where id='" . $id . "'"));
                                            $atul[] = $ides['id'];
                                            // print_r($ides['id']);
//				 exit();
                                        }
                                    }
                                    while ($catg = mysql_fetch_array($cat)) {
                                        $checked_cat = 0;
                                        if (isset($_POST['search-category']) && $_POST['search-category']) {

                                            //	print_r($_POST['search-category']);
//					exit();
//		echo "<pre>";	print_r($atul);
                                            //	die;  
                                            foreach ($atul as $O) {
                                                if ($O == $catg['id']) {
                                                    $checked_cat = 1;
                                                }
                                            }
                                        }
                                        ?>
                                        <li><input <?php if ($checked_cat == 1) { ?>checked="checked"<?php } ?> onClick="get_cetagory_list_side();" name="search-category[]" type="checkbox" value="<?php echo $catg['id']; ?>"><?php echo $catg['category_name'] ?></li>
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
                    <div id="clearall" class="classifiedd-news-category2 alignright" style="padding:0px"><input type="submit" class="search-btn" value="Search" name="side-search" /></div></div>
            </figcaption> 
        </figure> 
    </div><!-- ENDS Filter Listing -->
</form>