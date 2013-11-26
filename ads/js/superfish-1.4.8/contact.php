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
<title>CNFA News Ads</title>
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

if( text == '' || text == 'What are you searching for?' )
{
alert("Please Enter Search Text.");
return(false);
}
if( citycheak != 1 )
{
alert("Please Select City.");
return(false);
}

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

					alert("Enter Your Name");

					return(false);

					}

					if(document.frm.email.value=='' || document.frm.email.value==null)

					{

					alert("Enter Your Email");

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
            <a href="javascript:var _t = encodeURI(document.title);var _url = encodeURIComponent(document.location);var _appkey = encodeURI('27a537299f8b443280c1117e5d1b1b08');var _pic = encodeURI('');var _site = encodeURI('www.cnfanews.com');var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic+'&title='+_t;window.open( _u,'_blank', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );void(0);" title="ÌÚÑ¶Î¢²©"><img src="img/share-6.png" border="0"></a>
            <a href="javascript:(function(){window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url='+ encodeURIComponent(location.href)+ '&title='+encodeURIComponent('News Tilte'),'_blank');})()" title="QQ¿Õ¼ä"><img src="img/share-5.png" border="0"></a>
            <a href="javascript:var u='http://www.douban.com/recommend/?url='+location.href+'&title='+encodeURIComponent('News Tilte');window.open(u,'douban','toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330');void(0)" title="¶¹°êÍø"><img src="img/share-4.png" border="0"></a>
            <a href="javascript:d=document;t=d.selection?(d.selection.type!='None'?d.selection.createRange().text:''):(d.getSelection?d.getSelection():'');void(kaixin=window.open('http://www.kaixin001.com/~repaste/repaste.php?&rurl='+escape(d.location.href)+'&rtitle='+escape('News Tilte')+'&rcontent='+escape('News Tilte'),'kaixin'));kaixin.focus();"  title="¿ªÐÄÍø"><img src="img/share-3.png" border="0"></a>
            <a href="javascript:void((function(s,d,e){if(/xiaonei\.com/.test(d.location))return;var%20f='http://share.xiaonei.com/share/buttonshare.do?link=',u=d.location,l='News Tilte',p=[e(u),'&title=',e(l)].join('');function%20a(){if(!window.open([f,p].join(''),'xnshare',['toolbar=0,status=0,resizable=1,width=626,height=436,left=',(s.width-626)/2,',top=',(s.height-436)/2].join('')))u.href=[f,p].join('');};if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent));" title="ÈËÈËÍø"><img src="img/share-2.png" border="0"></a>
            <a href="javascript:(function(){window.open('http://v.t.sina.com.cn/share/share.php?appkey=3229244048&ralateUid=1916997175&title='+encodeURIComponent('News Tilte')+'&url='+encodeURIComponent(location.href)+'&source='+encodeURIComponent('·²ÎÅ·²ÊÂ')+'&sourceUrl='+encodeURIComponent('http://www.cnfanews.com'),'_blank','width=450,height=400');})()" title="ÐÂÀËÎ¢²©"><img src="img/share-1.png" border="0"></a>
                
                
                
                
                
            </div>
            <!--- end social-area ---->
        </div>
        <!--- end header-top ---->
        <!--- start red-search-section ---->
        <div class="red-search-section">
        	<form action="search.php" method="post" name="Query1" id="Query1" onSubmit="return valid_search();">
       		<div class="what-are-you-searching">
            	<input id="search-txt" class="what-are-you-searching-for" name="search-txt" value="What are you searching for?" size="16" type="text" onBlur="if (this.value == ''){this.value = 'What are you searching for?'; }" onFocus="if (this.value == 'What are you searching for?') {this.value = ''; }" />
            </div>
            <div class="all-newspaper">
            
            
            <a href="#" onClick="return showHide1();"><img src="img/down-arrow.png" border="0" align="right"/></a>
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
            	<a href="#" onClick="return showHide();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide();" >All Newspaper</p>
                <div id="showHideDiv" style="display:none;">
                <ul id="all_newspapers"></ul>
                </div>
                
            </div>
            <div class="all-cities">
            	<a href="#" onClick="return showHide2();"><img src="img/down-arrow.png" border="0" align="right"/></a>
                <p class="all-news-paper-content" onClick="return showHide2();">All Categories</p>
                
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
				


            	<h4 class="fa">Contact Us</h4>
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
                            	
                                <h6 class="news-paper-name">Please fill in the form below to contact us.</h6>
                            </div>
						  	<div id="clearall" class="classifiedd-news-category3">
                            
							<div class="classifiedd-news-category">
							
                            <form id="frm" name="frm" class="form1" method="post" action="" onSubmit="return valid();">
							<label>Full Name</label><input type="text" id="name" name="name" value="">
							<label>Your Email Address</label><input type="text" id="email" name="email" value="">
            				<label>Subject</label><input type="text" id="subject" name="subject" value="">
							<label>Message</label><textarea id="message" name="message" value=""></textarea>

 <!-- ... your form code here ... -->
        <script type="text/javascript">
 var RecaptchaOptions = {
    theme : 'custom',
    custom_theme_widget: 'recaptcha_widget'
 };
</script>
<label>Enter the words above:<span>Please enter the text exactly as it appears. Consider upper and lower case.</span></label>
<div id="recaptcha_widget" style="display:none">

   <div id="recaptcha_image"></div>
   <div class="recaptcha_only_if_incorrect_sol" style="color:red">Incorrect please try again</div>

  
   <span class="recaptcha_only_if_audio">Enter the numbers you hear:</span>

   <input type="text" id="recaptcha_response_field" name="recaptcha_response_field" />

   <div><a href="javascript:Recaptcha.reload()">Get another CAPTCHA</a></div>
   <div style="display:none;" class="recaptcha_only_if_image"><a href="javascript:Recaptcha.switch_type('audio')">Get an audio CAPTCHA</a></div>
   <div style="display:none;" class="recaptcha_only_if_audio"><a href="javascript:Recaptcha.switch_type('image')">Get an image CAPTCHA</a></div>

   <div style="display:none;"><a href="javascript:Recaptcha.showhelp()">Help</a></div>

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
<label></label><input class="btn" type="submit" id="send_message" name="Submit" value="Submit">

</form>

<address>
<h1>EASY WAY TO FIND US</h1>
<p>Envato Melbourne,<br/>
Little Lonsdale St, Melbourne<br/>
Rutrum faucibus road.</p> 

<p><span>Phone:</span> +01 (23) 456 7890<br/>
<span>Email:</span> contact@cnfa-ads.com<br/>
<span>Web:</span> cnfa-ads.com</p></address>
                            
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
    	<p class="fa-content"> &copy; Copyright <span class="footer-copyright-content">FA Classified Pvt. Ltd.</span> | Disclaimer, Terms of Service and Privacy policy</p>
    </div>
</footer>
<!--- end section ---->
</body>
</html>
