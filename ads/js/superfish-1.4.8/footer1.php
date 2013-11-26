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
                <li><a href="<?php echo $header_menu1['menu_url']; ?>"><?php echo $header_menu1['menu_name']; ?></a></li>
                
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

<script>
		(function () {
		
		    // Create mobile element
		    var mobile = document.createElement('div');
		    mobile.className = 'nav-mobile';
		    document.querySelector('.classifiedd-news-category1').appendChild(mobile);
		
		    // hasClass
		    function hasClass(elem, className) {
		        return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
		    }
		
		    // toggleClass
		    function toggleClass(elem, className) {
		        var newClass = ' ' + elem.className.replace(/[\t\r\n]/g, ' ') + ' ';
		        if (hasClass(elem, className)) {
		            while (newClass.indexOf(' ' + className + ' ') >= 0) {
		                newClass = newClass.replace(' ' + className + ' ', ' ');
		            }
		            elem.className = newClass.replace(/^\s+|\s+$/g, '');
		        } else {
		            elem.className += ' ' + className;
		        }
		    }
		
		    // Mobile nav function
		    var mobileNav = document.querySelector('.nav-mobile');
		    var toggle = document.querySelector('.classifiedd-news-category1-list');
		    mobileNav.onclick = function () {
		        toggleClass(this, 'nav-mobile-open');
		        toggleClass(toggle, 'nav-active');
		    };
		})();
		
		
		</script>
        
       <script>
		(function () {
		
		    // Create mobile element
		    var mobile = document.createElement('div');
		    mobile.className = 'nav-mobile2';
		    document.querySelector('.classifiedd-news-category2').appendChild(mobile);
		
		    // hasClass
		    function hasClass(elem, className) {
		        return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
		    }
		
		    // toggleClass
		    function toggleClass(elem, className) {
		        var newClass = ' ' + elem.className.replace(/[\t\r\n]/g, ' ') + ' ';
		        if (hasClass(elem, className)) {
		            while (newClass.indexOf(' ' + className + ' ') >= 0) {
		                newClass = newClass.replace(' ' + className + ' ', ' ');
		            }
		            elem.className = newClass.replace(/^\s+|\s+$/g, '');
		        } else {
		            elem.className += ' ' + className;
		        }
		    }
		
		    // Mobile nav function
		    var mobileNav = document.querySelector('.nav-mobile2');
		    var toggle = document.querySelector('.classifiedd-news-category2-list');
		    mobileNav.onclick = function () {
		        toggleClass(this, 'nav-mobile-open');
		        toggleClass(toggle, 'nav-active');
		    };
		})();
		
		
		</script>
        
   <script type="text/javascript">
   function valid_side_search()
{
var city = document.getElementsByName('search-cities[]');
var	citycheak = '';
for(var i=0; i< city.length; i++)
{
if( city[i].checked == true )
{
var	citycheak = 1;
}
}

if( citycheak != 1 )
{
alert("Please Select City.");
return(false);
}

}
</script>  
        
 <script type="application/javascript">
//This function displays the Share box when called
function vpb_share_box(name)
{
	jQuery("#vpb_pop_up_background").css({
		"opacity": "0.4"
	});
	jQuery("#vpb_pop_up_background").fadeIn("slow");
	jQuery("#vpb_share_box").fadeIn('fast');
	jQuery("#aa").attr("value",name);
	window.scroll(0,0);
}

function vpb_hide_popup_boxes()
{
    jQuery("#vpb_share_box").hide(); //Hides the Share box when clicked outside the form
}




</script>       
    
    

<div class="vpb_search_box pop-up-modal" id="vpb_share_box" style="display: none;">
<div class="login-box pop-up-modal-container">
<div id="modal-bg">
<div class="modal-header">
<div class="cls-btn"><a onclick="vpb_hide_popup_boxes();"><img border="0" src="http://204.197.244.110/~cnfanews/v1/dev/images/close-button.png"></a></div>

<h2>Share with your social network</h2></div>
<div class="clear"></div> 
<input type="hidden" value="" id="aa">
 <!--Sina Weibo-->
 <div class="modal-button" id="modal-rss-button">
<a href="javascript:(function(){window.open('http://v.t.sina.com.cn/share/share.php?appkey=3229244048&ralateUid=1916997175&title='+encodeURIComponent(document.getElementById('aa').value)+'&url='+encodeURIComponent('')+'&source='+encodeURIComponent('')+'&sourceUrl='+encodeURIComponent(''),'_blank','width=450,height=400');})()" title="Ã?Ã‚Ã€Ã‹ÃŽÂ¢Â²Â©">
<img alt="����΢��" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/sina-weibo1.png"></a> 
<h3>Sina Weibo</h3>
</div>


<!--renren-->
<div class="modal-button" id="modal-email-button">


<a title="������" href="javascript:void((function(s,d,e){if(/xiaonei\.com/.test(document.getElementById('aa').value))return;
var%20f='http://share.xiaonei.com/share/buttonshare.do?link=',u=d.location,l='News Tilte',p=[e(u),'&amp;title=',e(l)].join('');
function%20a(){if(!window.open([f,p].join(''),'xnshare',['toolbar=0,status=0,resizable=1,width=626,height=436,left=',(s.width-626)/2,',top=',(s.height-436)/2].join('')))u.href=[f,p].join('');};
if(/Firefox/.test(navigator.userAgent))setTimeout(a,0);else%20a();})(screen,document,encodeURIComponent));" id="">
        <img alt="������" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/renren.png"></a>
        <h3>Renren</h3>
</div>
      
<!--kaixin-->
<div class="modal-button" id="modal-email-button">
<a title="������" href="javascript:d=document;t=d.selection?(d.selection.type!='None'?d.selection.createRange().text:''):(d.getSelection?d.getSelection():'');
void(kaixin=window.open('http://www.kaixin001.com/~repaste/repaste.php?&amp;rurl='+escape(document.getElementById('aa').value)+'&amp;rtitle='+escape('News Tilte')+'&amp;rcontent='+escape('News Tilte'),'kaixin'));kaixin.focus();" id="">
        <img alt="������" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/kaixin.png"></a>
        <h3>Kaixin</h3>
</div>


<!--Tencent Weibo-->
<div class="modal-button" id="modal-email-button">

<a id="" href="javascript:var _t = encodeURI(document.title);
var _url = encodeURIComponent(document.getElementById('aa').value);
var _appkey = encodeURI('27a537299f8b443280c1117e5d1b1b08');
var _pic = encodeURI('');
var _site = encodeURI('www.cnfaads.com');
var _u = 'http://v.t.qq.com/share/share.php?url='+_url+'&appkey='+_appkey+'&site='+_site+'&pic='+_pic;window.open( _u,'_blank', 'width=700, height=680, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, location=yes, resizable=no, status=no' );
void(0);" title="ÌÚÑ¶Î¢²©"><img alt="��Ѷ΢��" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/tencent-big.png"></a>
<h3>Tencent Weibo</h3>
</div>


<!--Dou Ban-->
<div class="modal-button" id="modal-rss-button">
<a title="������" href="javascript:var u='http://www.douban.com/recommend/?url='+document.getElementById('aa').value+'&amp;title='+encodeURIComponent('News Tilte');window.open(u,'douban','toolbar=0,resizable=1,scrollbars=yes,status=1,width=450,height=330');void(0)" id="">
        <img alt="������" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/dou-ban.png"></a>
        <h3>Dou Ban</h3>
</div>


<!--qq Zone-->
<div class="modal-button" id="modal-rss-button">
<a title="QQ�ռ�" href="javascript:(function(){window.open('http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url='+ encodeURIComponent(document.getElementById('aa').value)+ '&amp;title='+encodeURIComponent('News Tilte'),'_blank');})()" id="">
            <img alt="QQ�ռ�" src="http://204.197.244.110/~cnfanews/cnfa-ads/v3/img/qq_zone.png"></a>
            <h3>qq Zone</h3>
</div>

<div class="clear"></div>     
</div>
</div></div>
    
    
    
        
</body>
</html>