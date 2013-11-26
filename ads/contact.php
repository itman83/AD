<?php
include('config.php');
?>
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
<!--<link href="responsive.css" rel="stylesheet" type="text/css" media="all"/>-->
<link rel="stylesheet" type="text/css" href="js/demo.css">
<!--<link rel="stylesheet" type="text/css" href="js/elastislide.css">-->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-1.2.6.pack.js"></script>
	
	
		<!-- JS -->
		<script src="js/jquery-1.7.1.min.js"></script>
		<script src="js/custom.js"></script>
		<script src="js/tabs.js"></script>
		<!--<script src="js/css3-mediaqueries.js"></script>-->
		<script src="js/jquery.columnizer.min.js"></script>
		

		<!-- Isotope -->
		<script src="js/jquery.isotope.min.js"></script>
		
		<!-- Lof slider -->
		<script src="js/jquery.easing.js"></script>
		<script src="js/lof-slider.js"></script>
		<!--<link rel="stylesheet" href="css/lof-slider.css" media="all"  />--> 
		<!-- ENDS slider -->
		
		<!-- Tweet -->
		<!--<link rel="stylesheet" href="css/jquery.tweet.css" media="all"  /> -->
		<script src="js/tweet/jquery.tweet.js" ></script> 
		<!-- ENDS Tweet -->
		
		<!-- superfish -->
		<!--<link rel="stylesheet" media="screen" href="css/superfish.css" />--> 
		<!--<script  src="js/superfish-1.4.8/js/hoverIntent.js"></script>-->
		<script  src="js/superfish-1.4.8/js/superfish.js"></script>
		<!--<script  src="js/superfish-1.4.8/js/supersubs.js"></script>-->
		<!-- ENDS superfish -->
		
		<!-- prettyPhoto -->
		<script  src="js/prettyPhoto/js/jquery.prettyPhoto.js"></script>
		<!--<link rel="stylesheet" href="js/prettyPhoto/css/prettyPhoto.css"  media="screen" />-->
		<!-- ENDS prettyPhoto -->
		
		<!-- poshytip -->
		<!--<link rel="stylesheet" href="js/poshytip-1.1/src/tip-twitter/tip-twitter.css"  />-->
		<!--<link rel="stylesheet" href="js/poshytip-1.1/src/tip-yellowsimple/tip-yellowsimple.css"  />-->
		<script  src="js/poshytip-1.1/src/jquery.poshytip.min.js"></script>
		<!-- ENDS poshytip -->
		
		<!-- JCarousel -->
		<script type="text/javascript" src="js/jquery.jcarousel.min.js"></script>
		<!--<link rel="stylesheet" media="screen" href="css/carousel.css" />--> 
		<!-- ENDS JCarousel -->


		<!-- GOOGLE FONTS -->
		<!--<link href='http://fonts.googleapis.com/css?family=Voltaire' rel='stylesheet' type='text/css'>-->
        <!--<link rel='stylesheet' id='default_secondary_font-css'  href='http://fonts.googleapis.com/css?family=Francois+One&#038;ver=3.5.1' type='text/css' media='all' />-->


		<!-- modernizr -->
		<script src="js/modernizr.js"></script>
	
		
		<!-- flexslider -->
		<!--<link rel="stylesheet" href="css/flexslider.css" >-->
		<script src="js/jquery.flexslider.js"></script>
        
        <script type="text/javascript" language="javascript">// <![CDATA[
	function showHide() {
    var ele = document.getElementById("showHideDiv");
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
    else {
        ele.style.display = "block";
    }
}

function showHide2() {
    var ele = document.getElementById("showHideDiv2");
    if(ele.style.display == "block") {
            ele.style.display = "none";
      }
    else {
        ele.style.display = "block";
    }
};

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


function valid_search()
{
var text = document.getElementById('search-txt').value;	
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
/*
if( citycheak != 1 )
{
alert("请选择城市.");
return(false);
}
*/
}

// ]]></script>
        
        <script type="text/javascript" src="http://www.cocoon.co.in/jquery-1.6.4.min.js"></script>
<script>

					function valid()

					{
						
						var name = document.getElementById('name').value;

						var email = document.getElementById('email').value;

						var subject = document.getElementById('subject').value;
						var message = document.getElementById('message').value;

						var capt = document.getElementById('recaptcha_response_field').value;
		
       					var capt1 = document.getElementById('recaptcha_challenge_field').value;

					if(document.frm.name.value=='' || document.frm.name.value==null)

					{

					alert("请输入您的姓名");

					return(false);

					}

					if(document.frm.email.value=='' || document.frm.email.value==null)

					{

					alert("请输入您的邮箱");

					return(false);

					}

					var x=document.frm.email.value;

var atpos=x.indexOf("@");

var dotpos=x.lastIndexOf(".");

if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)

  {

  alert("Enter Valid Email");

  return(false);

  }


if(document.frm.subject.value=='' || document.frm.subject.value==null)

					{

					alert("No subject specified");

					return(false);

					}
					
				if(document.frm.message.value=='' || document.frm.message.value==null)

					{

					alert("No message specified");

					return(false);

					}
					

					else{
 $.post(
"email.php",
{name: name, email: email, subject: subject, message: message, capt: capt, capt1: capt1},
function(data) {
if( data == '0' )
{
alert("Please fill correct captcha...");
Recaptcha.reload();
}
if( data == '1' )
{
window.location = 'http://localhost/cnfa/v1/index.php';
}
}
); 
 return(false);
}

}

</script>


        
        
<style type="text/css">


#recaptcha_image img{
    clear: both;
    float: left;
    height: 55px;
    margin-top: 7px;
    width:170px;
	}

.recaptcha_nothad_incorrect_sol a{
	color: #4C4C4C;
    font-size: 11px;
    text-decoration: underline;
	float:left;
	font-family:Arial, Helvetica, sans-serif;
	margin-left:10px;
	}

.recaptcha_only_if_image{
	float:left;
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	margin:5px 0px 0px 10px;
	}
	
#recaptcha_image {
	float:left;
	width:auto !important;
	height:auto !important;
	margin-left:0px;
}

#recaptcha_response_field {
	width:181px;
	margin-top:0px;
	float:left
}
.all-enq {
    font-family: 'Roboto Condensed',sans-serif;
    font-size: 16px;
    height: auto;
    margin: 15px 0 0 14px;
    padding: 0 0 0 10px;
    width: 386px;
}

</style>
		<!--<link rel="stylesheet" href="bundle.css">-->

</head>

<body>
<!--- start header ---->
<header>
	<!--- start header-inner ---->
	<div class="header-inner">
    	<!--- start header-top ---->
    	<div class="header-top">
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
                
                
                
                
            </div>
            <!--- end social-area ---->
        </div>
        <!--- end header-top ---->
        <!--- start red-search-section ---->
        <div class="red-search-section">
        	<form action="search.php" method="post" name="Query1" id="Query1" onSubmit="return valid_search();">
       		<div class="what-are-you-searching">
            	<input id="search-txt" class="what-are-you-searching-for" name="search-txt" value="这里总有你需要的" size="16" type="text" onBlur="if (this.value == ''){this.value = '这里总有你需要的'; }" onFocus="if (this.value == '这里总有你需要的') {this.value = ''; }" />
            </div>
            <div class="all-newspaper">
            
            
            <a href="#" onClick="return showHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
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
            	<a href="#" onClick="return showHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide();" >所有报刊</p>
                <div id="showHideDiv" style="display:none;">
                <ul id="all_newspapers"></ul>
                </div>
                
            </div>
            <div class="all-cities">
            	<a href="#" onClick="return showHide2();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide2();">所有栏目</p>
                
                <div id="showHideDiv2" style="display:none;">
                <ul id="all_categories">
                
                
                </ul>
                 </div>
            </div>
            
            <input type="submit" class="search"/>
            </form>
            
            
            
            
        </div>
        <!--- end red-search-section ---->
    </div>
    <!--- end header-inner ---->
    <div class="border-line">
    </div>
</header>
<!--- end header ---->
	<div class="wrapper1">
    	<!--- start fa-classified ---->
    		<div class="fa-classified">
				


            	<h4 class="fa">联系我们</h4>
            </div>
       </div>
<!--- start section ---->
<section>
	<!--- start wrapper ---->
	<div class="wrapper"> 
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
                            	
                                <h6 class="news-paper-name">请将你的意见和要求反馈给我们</h6>
                            </div>
						  	<div id="clearall" class="classifiedd-news-category3">
                            
							<div class="classifiedd-news-category">
							
                            <form id="frm" name="frm" class="form1" method="post" action="" onSubmit="return valid();">
							<label>姓名</label><input type="text" id="name" name="name" value="">
							<label>邮箱</label><input type="text" id="email" name="email" value="">
            				<label>主题</label><input type="text" id="subject" name="subject" value="">
							<label>意见和建议</label><textarea id="message" name="message" value=""></textarea>

 <!-- ... your form code here ... -->
        <script type="text/javascript">
 var RecaptchaOptions = {
    theme : 'custom',
    custom_theme_widget: 'recaptcha_widget'
 };
</script>
<label>输入验证码:<span>请正确输入验证码<br/>（注意大小写）</span></label>
<div id="recaptcha_widget" style="display:none">

   <div id="recaptcha_image"></div>
   <div class="recaptcha_only_if_incorrect_sol" style="color:red">验证码错误，请重试。</div>

  
   <span class="recaptcha_only_if_audio">请输入您听到的验证码:</span>

   <input type="text" id="recaptcha_response_field" name="recaptcha_response_field" />

   <div><a href="javascript:Recaptcha.reload()">重新获取图片</a></div>
   <div style="display:none;" class="recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')">重新获取音频验证码</a></div>
   <div style="display:none;" class="recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')">重新获取图片验证码</a></div>

   <div style="display:none;"><a href="javascript:Recaptcha.showhelp()">帮助</a></div>

 </div>

<script type="text/javascript"
   src="http://www.google.com/recaptcha/api/challenge?k=6LfMHuISAAAAAMvIMMVOMWWpBsXe7aYlcR-CSfvg">
 </script>
 <noscript>
   <iframe src="http://www.google.com/recaptcha/api/noscript?k=6LfMHuISAAAAAMvIMMVOMWWpBsXe7aYlcR-CSfvg"
       height="300" width="500" frameborder="0"></iframe><br>
   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
   </textarea>
   <input type="hidden" name="recaptcha_response_field" 
       value="manual_challenge">
 </noscript>
 

    <!-- ... more of your form code here ... -->
<label></label><input class="btn" type="submit" id="send_message" name="Submit" value="提交">

</form>

<address>
<h1>找到我们</h1>
<p>杭州凡闻科技有限公司<br/>
杭州市石桥路永华街121号<br/></p> 

<p>
    
    <span>电话:</span> 0571-85331960<br/>
    <span>传真:</span> 0571-85331960<br/>
<span>邮箱:</span> info@cnfanews.com<br/>
<span style="word-break:keep-all;white-space:nowrap;">网站:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.hzfanwen.com" target="_blank" >http://www.hzfanwen.com</a></span><br/></p></address>
                            
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
<footer>
	<div class="footer-wrapper">
    	<div class="footer-nav">
        	<ul>
            
           <?php
				$header_menu = mysql_query("SELECT * FROM menu WHERE footer_menu = 1 AND status = 1");	
				while( $header_menu1 = mysql_fetch_array($header_menu) )
				{
				?>
                <li><a href="<?php echo $header_menu1['menu_url']?>"><?php echo $header_menu1['menu_name']?></a></li>
                
                 <?php } ?>
            
               <!-- <li><a href="contact.php">Contact</a></li>
                <li><a href="help.php">Help</a></li>
                <li><a href="latest-clasified.php">Latest Classified</a></li>-->
            </ul>
        </div>
        
    </div>
    <div class="footer-copyright">
    	<p class="fa-content"> &copy; 版权所有 <span class="footer-copyright-content">杭州凡闻科技有限公司</span> | 浙ICP备12039594号</p>
    </div>
</footer>
<!--- end section ---->
</body>
</html>
