<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie10 lt-ie9 lt-ie8 ie7" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie10 lt-ie9 ie8" lang="en"> <![endif]-->
<!--[if IE 9 ]>   <html class="no-js lt-ie10 ie9" lang="en"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->	<html class="no-js" lang="en"> <!--<![endif]-->
<head>
<meta name=viewport content="width=device-width, initial-scale=1.0, minimum-scale=1.0 maximum-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><?php  ob_start();?>
<title>凡人凡事-报刊分类广告</title>
<link rel="shortcut icon" href="img/frfs.ico" type="image/x-icon">
<link rel="stylesheet" media="all" href="css/style-cat.css"/>
<link href="style.css" type="text/css" rel="stylesheet"/>
<link rel="stylesheet" media="all" href="css/base.min.css" />
<link rel="stylesheet" media="all" href="css/3-960-grid.css" />
<link rel="stylesheet" type="text/css" href="js/demo.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
			
		function last_msg_funtion() 
		{
		  // var city     = 	document.getElementsByName('city_name[]');
		   var category = 	document.getElementsByName('cat_name[]');
		 
		  /* var city_id = '';
		   for(var i = 0; i < city.length; i++)
{
	if( city[i].checked == true )
			city_id =city_id + city[i].value+',';
}
var ids = city_id.substring(',', city_id.length - 1);
*/

 var cat_id = '';
		   for(var i = 0; i < category.length; i++)
{
	if( category[i].checked == true )
			cat_id = cat_id + category[i].value+',';
}
var catids = cat_id.substring(',', cat_id.length - 1);
if( cat_id == '' || cat_id == null )
{
catids = '0';	
}

           var ID=$(".message_box:last").attr("id");
	if( catids != 0 ){
		/*document.getElementById('0').style.display = 'none';
		document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>Please Select City</h1></div><div id='last_msg_loader'></div>";
		document.getElementById('0').style.display = 'none';*/
		
			$('div#last_msg_loader').html('<img src="ajax_loader-2.gif">');
			$.post("newspaper.php?action=get&id=<?php echo $cat?>&category="+catids+"&last_msg_id="+ID,
			
			function(data){
				if (data != "") {
				
				$(".message_box:last").after(data);
					$("#test").fadeIn(2000);
					document.getElementById('test').id = '';
				}
				$('div#last_msg_loader').empty();
			});
		}; 
		/*if( city_id == '' ){
	document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>Please Select City</h1></div><div id='last_msg_loader'></div>";
		}*/}
		$(window).scroll(function(){
			if ($(window).scrollTop() >= $(document).height() - $(window).height() - 60) {
			   last_msg_funtion();
			}
		}); 
		
	});
	
	
	function last_msg_funtion1() 
		{ 
		
		  // var city     = 	document.getElementsByName('city_name[]');
		   var category = 	document.getElementsByName('cat_name[]');
		 
		  /* var city_id = '';
		   for(var i = 0; i < city.length; i++)
{
	if( city[i].checked == true )
			city_id =city_id + city[i].value+',';
}
var ids = city_id.substring(',', city_id.length - 1);
*/

 var cat_id = '';
		   for(var i = 0; i < category.length; i++)
{
	if( category[i].checked == true )
			cat_id = cat_id + category[i].value+',';
}
var catids = cat_id.substring(',', cat_id.length - 1);
if( cat_id == '' || cat_id == null )
{
catids = '0';	
}

           var ID='0';
	if( catids != 0 ){
		document.getElementById('0').style.display = 'none';
		document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>请选择城市</h1></div><div id='last_msg_loader'></div>";
		document.getElementById('0').style.display = 'none';
		
			$('div#last_msg_loader').html('<img src="ajax_loader-2.gif">');
			$.post("newspaper.php?action=get&id=<?php echo $cat?>&category="+catids+"&last_msg_id="+ID,
			
			function(data){
				if (data != "") {
				
				$(".message_box:last").after(data);
					$("#test").fadeIn(2000);
					document.getElementById('test').id = '';
				}
				$('div#last_msg_loader').empty();
			});
		}; 
		/*if( city_id == '' ){
	document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>Please Select City</h1></div><div id='last_msg_loader'></div>";
		}*/
		}
		
	</script>
<script src="js/jquery-1.7.1.min.js"></script>
<script src="js/custom.js"></script>
<script src="js/tabs.js"></script>
<script src="js/jquery.columnizer.min.js"></script>
<script src="js/jquery.isotope.min.js"></script>
<script src="js/jquery.easing.js"></script>
<script src="js/lof-slider.js"></script>
<script src="js/tweet/jquery.tweet.js" ></script> 
<script  src="js/superfish-1.4.8/js/superfish.js"></script>
<script  src="js/prettyPhoto/js/jquery.prettyPhoto.js"></script>
<script  src="js/poshytip-1.1/src/jquery.poshytip.min.js"></script>
<script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
<script src="js/modernizr.js"></script>
<script src="js/jquery.flexslider.js"></script>

       
<script>
function check_all(source)
{
	
var city = 	document.getElementsByName('city_name[]');
if( source.checked == true )
{
	
for(var i = 0; i < city.length; i++)
{
			city[i].checked = true;
}
document.getElementById('0').style.display = 'none';
}
if( source.checked == false )
{
for(var i = 0; i < city.length; i++)
{
			city[i].checked = false;
}	
document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>请选择城市</h1></div><div id='last_msg_loader'></div>";

}

last_msg_funtion1();
}




function check_all_cat(source)
{
	
var city = 	document.getElementsByName('cat_name[]');
if( source.checked == true )
{
	
for(var i = 0; i < city.length; i++)
{
			city[i].checked = true;
}
document.getElementById('0').style.display = 'none';
}
if( source.checked == false )
{
for(var i = 0; i < city.length; i++)
{
			city[i].checked = false;
}	
document.getElementById('clearall').innerHTML = "";
document.getElementById('clearall').innerHTML = "<div align='left' class='message_box' style='display:block;' id='0'><h1>请选择城市</h1></div><div id='last_msg_loader'></div>";

}

last_msg_funtion1();
}
</script> 
        <script type="text/javascript" language="javascript">// <![CDATA[
	function showHide() {
    var ele = document.getElementById("showHideDiv");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
		 var ale = document.getElementById("showHideDiv2");
	if(ale.style.display == "block") {
            ale.style.display = "none";
      } 
	  
	 var ble = document.getElementById("showHideDiv1");
	if(ble.style.display == "block") {
            ble.style.display = "none";
      }   
	  
    else {
        ele.style.display = "block";
    }
}

function newsHide() {
    var ele = document.getElementById("showHidenews");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
    else {
        ele.style.display = "block";
    }
}

function catHide() {
    var ele = document.getElementById("showHidecat");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
    else {
        ele.style.display = "block";
    }
}

function showHide1() {
    var ele = document.getElementById("showHideDiv1");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	 
		 var ale = document.getElementById("showHideDiv");
	if(ale.style.display == "block") {
            ale.style.display = "none";
      } 
	  
	 var ble = document.getElementById("showHideDiv2");
	if(ble.style.display == "block") {
            ble.style.display = "none";
      }  
	  
    else {
        ele.style.display = "block";
    }
}

function showHide2() {
    var ele = document.getElementById("showHideDiv2");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	  
	 var ale = document.getElementById("showHideDiv");
	if(ale.style.display == "block") {
            ale.style.display = "none";
      } 
	  
	 var ble = document.getElementById("showHideDiv1");
	if(ble.style.display == "block") {
            ble.style.display = "none";
      }  
	  
    else {
        ele.style.display = "block";
    }
};

function closeall(){
	var ele = document.getElementById("showHidenews");
	if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	
	 var ele = document.getElementById("showHidecity1");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	 
	 var ele = document.getElementById("showHidecat");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	 
	}

function closehead(){
	var ele = document.getElementById("showHideDiv1");
	if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	  
	 var ele = document.getElementById("showHideDiv");
	if(ele.style.display == "block") {
            ele.style.display = "none";
      } 
	  
	  var ele = document.getElementById("showHideDiv2");
	if(ele.style.display == "block") {
            ele.style.display = "none";
      }
	  
	}


function cityHide1() {
    var ele = document.getElementById("showHidecity1");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
    else {
        ele.style.display = "block";
    }
}

function get_cetagory_list()
{
var city = document.getElementsByName('search-cities[]');
var cities = '';
for(var i=0; i< city.length; i++)
{
if( city[i].checked == true )
{
	cities = cities+city[i].value+',';
}
}
var cty = cities.substring(',', cities.length - 1);
$.post(
"get_cetagory_list.php",
{cty:cty},
function(data) {
if( data != '' )
{
document.getElementById('all_newspapers').innerHTML = '';	
document.getElementById('all_newspapers').innerHTML = data;
}
if( data == '' )
{
document.getElementById('all_newspapers').innerHTML = '';
}
}
); 
}


function get_cetagory_list_side()
{
var city = document.getElementsByName('search-cities[]');
var cities = '';
for(var i=0; i< city.length; i++)
{
if( city[i].checked == true )
{
	cities = cities+city[i].value+',';
}
}
var cty = cities.substring(',', cities.length - 1);
$.post(
"get_cetagory_list_side.php",
{cty:cty},
function(data) {
if( data != '' )
{
document.getElementById('all_newspapers_side').innerHTML = '';	
document.getElementById('all_newspapers_side').innerHTML = data;
}
if( data == '' )
{
document.getElementById('all_newspapers_side').innerHTML = '';
}
}
); 
}



function get_newspaper_list()
{
var news = document.getElementsByName('search-news[]');
var newspaper = '';
for(var i=0; i< news.length; i++)
{
if( news[i].checked == true )
{
	newspaper = newspaper+news[i].value+',';
}
}
var nws = newspaper.substring(',', newspaper.length - 1);
$.post(
"get_newspaper_list.php",
{nws:nws},
function(data) {
if( data != '' )
{
document.getElementById('all_categories').innerHTML = '';	
document.getElementById('all_categories').innerHTML = data;
}
if( data == '' )
{
document.getElementById('all_categories').innerHTML = '';
}
}
); 
}


function get_newspaper_list_side()
{
var news = document.getElementsByName('search-news[]');
var newspaper = '';
for(var i=0; i< news.length; i++)
{
if( news[i].checked == true )
{
	newspaper = newspaper+news[i].value+',';
}
}
var nws = newspaper.substring(',', newspaper.length - 1);
$.post(
"get_newspaper_list.php",
{nws:nws},
function(data) {
if( data != '' )
{
document.getElementById('all_categories_side').innerHTML = '';	
document.getElementById('all_categories_side').innerHTML = data;
}
if( data == '' )
{
document.getElementById('all_categories_side').innerHTML = '';
}
}
); 
}


function valid_search()
{ //divid=document.getElementById('all_categories');
//alert(document.getElementById('all_categories'));
var text = document.getElementById('search-txt').value;	
var city =  document.getElementById("showHideDiv1").getElementsByTagName("*");
var	citycheak = ''; 
for(var i=0; i< city.length; i++)
{ if(city[i].checked==true &&  (city[i].tagName)=='INPUT')
{
citycheak=1;
}

}

if( text == '' || text == '这里总有你需要的' )
{
alert("这里总有你需要的.");
return(false);
}


}


function valid_modify_search()
{
var text = document.getElementById('search-txt-side').value;	
var city = document.getElementsByName('search-cities[]');
var	citycheak = '';
for(var i=0; i< city.length; i++)
{
if( city[i].checked == true )
{
var	citycheak = 1;
}
}

if( text == '' || text == '这里总有你需要的' )
{
alert("请输入搜索关键词.");
return(false);
}
if( citycheak != 1 )
{
alert("请选择城市.");
return(false);
}

}
// ]]></script>

</head>

<body>



<!--- start header ---->
<header>
	<!--- start header-inner ---->
	<div class="header-inner" onClick="closeall();">
    	<!--- start header-top ---->
    	<div class="header-top" onClick="closehead();">
        	<!--- start logo-area ---->
            <div class="logo-area">
                <a href="index.php"><img src="img/logo.png" border="0"/></a>
            </div>
            <!--- end logo-area ---->
            <!--- start header-nav ---->
            <div class="header-nav">
            	<ul>
                
                <?php
				$header_menu = mysql_query("SELECT * FROM menu WHERE header_menu = 1 AND status = 1");	
				while( $header_menu1 = mysql_fetch_array($header_menu) )
				{
				?>
                <li><a href="<?php echo $header_menu1['menu_url']?>"><?php echo $header_menu1['menu_name']?></a></li>
                
                 <?php } ?>
                
                	
                </ul>
            </div>
            <!--- end header-nav ---->
            <!--- start social-area ---->
             <div class="social-area">
              <a href="http://weibo.com/u/3748852832" target="_blank"><img src="img/top-icons/sina-weibo.png" border="0"></a>
              <a href="http://t.qq.com/fs2043525960" target="_blank"><img src="img/top-icons/tencent-weibo.png" border="0"></a>
              <a href="http://www.renren.com/553368194/profile" target="_blank"><img src="img/top-icons/renren.png" border="0"></a>
              <a href="http://www.kaixin001.com/home/?_profileuid=156475950" target="_blank"><img src="img/top-icons/kaixin.png" border="0"></a>
              <a href="http://www.douban.com/people/77141897/" target="_blank"><img src="img/top-icons/douban.png" border="0"></a>
              <a href="http://user.qzone.qq.com/2043525960/infocenter" target="_blank"><img src="img/top-icons/QQ-zone.png" border="0"></a>
              <!--<a href="https://mp.weixin.qq.com/cgi-bin/userinfopage?t=wxm-setting&lang=zh_CN&token=1748786264" target="_blank"><img src="img/top-icons/WeChat.png" border="0"></a>-->
                
                
                
                
                
            </div>
            <!--- end social-area ---->
        </div>
        <!--- end header-top ---->
        <!--- start red-search-section ---->
        <?php include 'advanced-search.php' ?>
        <!--- end red-search-section ---->
    </div>
    <!--- end header-inner ---->
    <div class="border-line">
    </div>
</header>
<!--- end header ---->