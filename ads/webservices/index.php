<?php ob_start();

 header('Content-Type:text/html; charset=UTF-8');
 $link = mysql_connect('localhost','root','09936e96') or die('Cannot connect to the DB');
  mysql_select_db('cnfanews_cnfa-ads-v2',$link) or die('Cannot select the DB');
   mysql_query("SET character_set_results = 'utf8', character_set_client = 'utf8', character_set_connection = 'utf8', character_set_database = 'utf8', character_set_server = 'utf8'");

 //echo "tes22t";
// GET ALL NEWSPAPER NAME FROM NEWSPAPER TABLE ###############################################

if($_GET['action']=='newspapers')
			  {
				 //echo "test";
				 
				
		  $result=mysql_query("select id,newspaper_name as new,CONCAT('http://204.197.244.110/~cnfanews/cnfa-ads/news_logo/',id,'.jpg') as logo,update_time,CONCAT(id,'.jpg') as image from newspapers where status = 1");
		
			  
			    
		$posts = array();
       if(mysql_num_rows($result)) {
       while($post = mysql_fetch_assoc($result)) {
       $posts[] = array('post'=>$post);
       }
       }
	 asort($posts);
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
       }
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
		
				  }
				  
###################################################################################################				CHECK ALL NEWSPAPER NAME FROM NEWSPAPER TABLE UPDATED OR NOT
###################################################################################################

if($_GET['action']=='check' && $_GET['type']=='newspapers')
			  {
				
		 $result=mysql_num_rows(mysql_query("select * from newspapers where view=0"));
				  
	  if( $result > 0 )
	  {
	     header('Content-type: text/xml');
         echo '<posts>';
		 echo '<update>';
		 echo '1';
		 echo '</update>';
         echo '</posts>';
	  }
	  else
	  {
		 header('Content-type: text/xml');
         echo '<posts>';
		 echo '<update>';
		 echo '0';
		 echo '</update>';
         echo '</posts>';
	  }
				  
				  }

########################### End Check ###############################
########################### Update view data ###############################

if($_GET['action']=='update' && $_GET['type'] = 'newspapers' )
			  {
				  
				$update=mysql_query("update newspapers SET view=1 where id > 0");
		
	      if($update)
		  {header('Content-type: text/xml');
		     echo '<result>';
             echo 'updated';
			 echo '</result>';
		  }
		  else
		    {header('Content-type: text/xml');
		     echo '<result>';
             echo 'error';
			 echo '</result>';
		  }
				  
			  }

########################### End Update view data ###############################				  
				  
#############################################################  search #############

if($_GET['action']=='view' && $_GET['type'] = 'newspapers' )
			  {
		 $result=mysql_query("select id,newspaper_name as new,logo,creation_time as update_time,logo as image,view from newspapers where view=0");
				  
		$posts = array();
       if(mysql_num_rows($result)) {
       while($post = mysql_fetch_assoc($result)) {
       $posts[] = array('post'=>$post);
       }
       }
	 
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
               if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val,'</',$tag,'>';
			  else if( $tag == 'update_time' )
              echo '<',$tag,'>',strtotime($val),'</',$tag,'>';
			  else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
       }
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
		
				  }
				  


##################################### FIND CATEGORIES  ############################################
if($_GET['action']=='findcat')
			  {
				  $posts = array();
				  $ads   = array();
		$query  = "SELECT  category_id  FROM category_to_newspaper WHERE newspaper_id = '".$_GET['newspaper_id']."'";
        $result =  mysql_query($query,$link) or die('Errant query:  '.$query);	
	   while($data=mysql_fetch_assoc($result))
	   {
		  
	   $city  = "SELECT id ,category_name as category, CONCAT('http://204.197.244.110/~cnfanews/cnfa-ads/category_logo/',id,'.jpg') as logo,CONCAT(id,'.jpg') as image,update_time   FROM category WHERE id='".$data['category_id']."'";
       $cities =  mysql_query($city,$link) or die('Errant query:  '.$city);	

       $total_ads = mysql_fetch_array(mysql_query("Select COUNT(id) as total_ads FROM ads WHERE category_id ='".$data['category_id']."'"));
	  
     // print_r($total_ads); exit(); 
       if(mysql_num_rows($cities)) {
       while($post = mysql_fetch_assoc($cities)) {
		    $ads[$post['id']] = "<total_ads>".$total_ads['total_ads']."</total_ads>";
       $posts[] = array('post'=>$post);
	    }
       }
	   }
	//  print_r($ads); exit();
	   
	    asort($posts);
	 
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
		   if( $tag == 'image' )
			   {
				
              echo '<',$tag,'>',$val,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>',$val,'</',$tag,'>';
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  if( $tag == 'id' )
			   {
			  echo $ads[$val];
			   }
       }
       }
          echo '</',$key,'>';
       }
       }
       }
	 
       echo '</posts>';
	   
	   
			  }
			  


if($_GET['action']=='city')
 {
		 $result=mysql_query("select * from cities WHERE status = 1");
				  
		$posts = array();
       if(mysql_num_rows($result)) {
       while($post = mysql_fetch_assoc($result)) {
       $posts[] = array('post'=>$post);
       }
       }
	  asort($posts);
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
               if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val,'</',$tag,'>';
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
       }
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
		
				  }
				  
				  

if( $_GET['search'] )
 {
	 //echo $_GET['search']; echo "hello";
		 $result=mysql_query("select id,newspaper_name as new,logo,update_time,logo as image from newspapers WHERE newspaper_name LIKE '%".$_GET['search']."%' AND status = 1");
				  
		$posts = array();
       if(mysql_num_rows($result)) {
       while($post = mysql_fetch_assoc($result)) {
       $posts[] = array('post'=>$post);
       }
       }
	  asort($posts);
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
               if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val,'</',$tag,'>';
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
       }
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
		
				  }
##################################### FIND ADS  ##################################################
if($_GET['action']=='findads')
			  {
				  $posts = array();
	            $posts1 = array();
		
$cat = "SELECT id ,ads_title as title,city as city_id, ads_desc as description,creation_time,update_time FROM ads WHERE category_id='".$_GET['category_id']."' AND status = 1";
	
       $cat =  mysql_query($cat) or die('Errant query:'.$cat);	
       
       
       if(mysql_num_rows($cat)) {
       while($post = mysql_fetch_assoc($cat)) {
     $city  = mysql_fetch_assoc(mysql_query("SELECT city_name  FROM cities WHERE id='".$post['city_id']."'"));  
       $post['city_name']=$city['city_name'];
	   $posts[] = array('post'=>$post);
	   //$posts[] = $city['city_name'];
	  // $posts1[] = array('city'=>$city);
       }
       }
	
	   asort($posts);
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val) {
		   
			  echo '<',$tag,'>',$val,'</',$tag,'>';
       }
       }
	   else
	   echo $value;
          echo '</',$key,'>';
       }
       }
       }
	   echo '</posts>';
	   
			  }
##################################### END ADS  ###################################################	
##################################### FIND NEWS  #############################################
if($_GET['action']=='findnews')
			  {
		$posts = array();
		
 $get3  = mysql_query("SELECT  id,newspaper_name,logo,logo as image,creation_time,update_time  FROM newspapers WHERE city_id = '".$_GET['city_id']."' AND status = 1");
	    
       if(mysql_num_rows($get3)) {
       while($post = mysql_fetch_assoc($get3)) {
       $posts[] = array('post'=>$post);
       }
       }
	 
	  
	 asort($posts);
	   
	 
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) { 
       foreach($post as $key => $value) {
       echo '<',$key,'>'; 
       if(is_array($value)) {
	   //print_r();
       foreach($value as $tag => $val) {
		   if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   } 
			 else  if( $tag == 'logo' )  
             {   $val1 = preg_replace('#[^/]*$#', '', $val); 
			      $arr = explode("/", $val1);
$val1 = str_replace(trim($arr[0]),'news_logo',trim($val1));
			 echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val1.$value[id].'.jpg','</',$tag,'>';}
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
       }   
       }
          echo '</',$key,'>';
       }
       }
       }
	 
       echo '</posts>';
	   
	   
			  }
##################################### END NEWS  ##############################################	  
				  
######################################## About us ###########################################################				  
if( $_GET['action']=='aboutus' )
 {

	 
		 $result=mysql_fetch_assoc(mysql_query("select id from menu WHERE menu_reference='aboutus'"));
	
		 $result=mysql_fetch_assoc(mysql_query("select content,update_time from  pages WHERE menu_id='".$result['id']."'"));
		 
			  
		$posts = array();
        foreach($result as $index => $post) {
	    $msg=array("command"=>$_REQUEST['action'],"content"=>trim($post));
        $output =json_encode($msg);
        print $output; exit; 
		}
	   /*header('Content-type: text/xml ');
       echo '<posts>';
       foreach($result as $index => $post) {
		$post=  trim(strip_tags(str_replace("&nbsp;", '', $post)));
       echo '<',$index,'>', $post,'</',$index,'>';
	   
       }
	  
       echo '</posts>';
		*/
				  }
				  
######################################## End About us ###########################################################

######################################## Contact us ###########################################################				  
if( $_GET['action']=='contactus'  )
 {
	 if($_GET['name'] && $_GET['email'] )
{
	
	$sql=mysql_query("insert into contact_us(name,email,phone,subject,message)VALUE('".$_GET['name']."','".$_GET['email']."','".$_GET['phone']."','".$_GET['subject']."','".$_GET['message']."')");
	
$to = "ram.kumar@search-value.com";
$subject = $_GET['subject'];
$txt = $_GET['message'];
$headers = "From: ".$_GET['email']."" . "\r\n" ;
$data=mail($to,$subject,$txt,$headers);
	if($data)
	{
		header('Content-type: text/xml');
       echo '<posts>';
       echo '<result>','Mail Send Sucessfully','</result>';
	   echo '</posts>';	
		}
		else
		{
		header('Content-type: text/xml');
       echo '<posts>';
       echo '<result>','Error :- Not Mail Send','</result>';
	   echo '</posts>';		
			}
	
	}
 }
				  
######################################## End Contact us ###########################################################	
######################################## Terms of use us ###########################################################				  
if( $_GET['action']=='termsofuse' )
 {
       
	 
		 $result=mysql_fetch_assoc(mysql_query("select id from menu WHERE menu_reference='termsofuse'"));
	
		 $result=mysql_fetch_assoc(mysql_query("select content,update_time from  pages WHERE menu_id='".$result['id']."'"));
		 
			  
		$posts = array();
        foreach($result as $index => $post) {
	    $msg=array("command"=>$_REQUEST['action'],"content"=>trim($post));
        $output =json_encode($msg);
        print $output; exit;
	    }
	  /* header('Content-type: text/xml');
       echo '<posts>';
       foreach($result as $index => $post) {
	    $con_terms =trim(strip_tags(str_replace("&nbsp;", '', $post)));
		   //$con_terms=(str_replace(".com",".com/n ",strip_tags($post)));
       echo '<',$index,'>',strip_tags($con_terms),'</',$index,'>';
	   
       } 
	  
       echo '</posts>';
		*/
				  }
				  
######################################## End Terms of use ###########################################################
######################################## Privacy ###########################################################				  
if( $_GET['action']=='privacy' )
 {

	 echo "sd";
		 $result=mysql_fetch_assoc(mysql_query("select id from menu WHERE menu_reference='Privacy'"));
	
		 $result=mysql_fetch_assoc(mysql_query("select content,update_time from  pages WHERE menu_id='".$result['id']."'"));
		// print_r($result); exit;
			  
		$posts = array();
         foreach($result as $index => $post) { 
	  
	  
	    $msg=array("command"=>$_REQUEST['action'],"content"=>trim($post));
        $output =json_encode($msg);
        print $output; exit;
	    }
	 
	/*   header('Content-type: text/xml');
       echo '<posts>'; 
       foreach($result as $index => $post) {
		  $post=trim(strip_tags(str_replace("&nbsp;", '', $post)));
       echo '<',$index,'>',trim(strip_tags(str_replace("&nbsp;", '', $post))),'</',$index,'>';
	   
       } 
	  // exit;
       echo '</posts>';
		*/
				  }
				  
######################################## End Privacy ###########################################################
######################################## City Search ###############################################################
if( $_GET['action']=='search' )
 {
	  //echo  $_GET['action'];
	  //echo $_GET['data'];


	 if( $_GET['data']!='' )
	 {
		 $posts = array();
		//echo "select id,city_name,status,update_time from cities WHERE city_name like '".$_GET['data']."%'";
		$rs=mysql_query("select id,city_name,status,update_time from cities WHERE city_name like '".$_GET['data']."%' AND status = 1");
		
	 	while( $result=mysql_fetch_assoc($rs))
		{
			
		$posts[]=array("post"=>$result);	
		} 
		 
	 
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  }
 }

######################################## End City Search ################################################################
######################################## search city wise ###############################################################
if( $_GET['action']=='news_city' )
 {
	
	  $data=$_GET['name'];
	  if($_GET['name'])
	  {
   
	$rs=mysql_fetch_assoc(mysql_query("select category_id from ads WHERE city='".$_GET['name']."' AND status = 1"));
	$rs=mysql_fetch_assoc(mysql_query("select newspaper_id from category WHERE id='".$rs['category_id']."'"));
	$rs1=mysql_query("select id,newspaper_name,update_time as news_update_time from newspapers WHERE id='".$rs['newspaper_id']."' AND status = 1");

$cat=mysql_query("select id as category_id,category_name ,update_time,logo, logo as image from category WHERE newspaper_id='".$rs['newspaper_id']."'");
		 $posts = array();
		 $post1 = array();
		 
	 	while( $result=mysql_fetch_assoc($cat))
		{
			
		$posts[]=array("post"=>$result);	
		} 
		while( $result=mysql_fetch_assoc($rs1))
		{
			
		$post1[]=array("new"=>$result);	
		}
		 
	 
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			 if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val,'</',$tag,'>';
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       
	    
       foreach($post1 as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
      
	   echo '</posts>';
	   
				  }
 }

######################################## End Search city wise ###########################################################
######################################## End  city desc ###########################################################
if( $_GET['action']=='news_city' )
 {

	  if($_GET['cat_id'])
	  {
		
if(mysql_fetch_assoc(mysql_query("select * from category WHERE newspaper_id='".$_GET['news_id']."' and id='".$_GET['cat_id']."'")))
$cat=mysql_query("select id,ads_title,ads_desc ,creation_time,update_time,category_id,city from ads WHERE category_id='".$_GET['cat_id']."' and city='".$_GET['city_id']."' AND status = 1");

		 $posts = array();
		 $post1 = array();
		 $post2 = array();
	
	 	while( $result=mysql_fetch_assoc($cat))
		{
			$dt=mysql_fetch_assoc(mysql_query("select newspaper_id from category where id='".$result['category_id']."'"));
			$da=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where id='".$dt['newspaper_id']."'"));
			$ds=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$result['city']."'"));
		$posts[]=array("post"=>$result);
		$post1[]=array("city-name"=>$ds['city_name']);
		$post2[]=array("newspaper-name"=>$da['newspaper_name']);
		} 
				 
	 
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
             
			 if( $tag=="category_id" || $tag=="city")
			  $ss=1;
			  else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
	   foreach($post1 as $index => $post) {
       if(is_array($post)) {
       foreach($post as $tag => $val)
            
			 if( $tag=="category_id" || $tag=="city")
			  $ss=1;
			  else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
		}
      
         foreach($post2 as $index => $post) {
       
       if(is_array($post)) {
       foreach($post as $tag => $val)
        
			 if( $tag=="category_id" || $tag=="city")
			  $ss=1;
			  else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
         
       }
          echo '</',$key,'>';
       }
       }
       }
	}
	 
       
    
	   echo '</posts>';
	   
				  }
 }
######################################## End Search city wise ###########################################################
######################################## Category ###############################################################
if( $_GET['action']=='order' )
 {

	  if($_GET['city_id'])
	  {
		
if(mysql_fetch_assoc(mysql_query("select * from category WHERE newspaper_id='".$_GET['news_id']."'")))
{
$cat=mysql_fetch_assoc(mysql_query("select category_id from ads WHERE city='".$_GET['city_id']."' AND status = 1"));
$cat=mysql_query("select id as category_id,category_name ,update_time,logo, logo as image  from category WHERE id='".$cat['category_id']."'");
		 $posts = array();
	
	 	while( $result=mysql_fetch_assoc($cat))
		{
			
		$posts[]=array("post"=>$result);	
		}  
		
      
	
	 
	  header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			 if( $tag == 'image' )
			   {
				   $dat=explode("/",$val);
				      $dat=end($dat);
              echo '<',$tag,'>',$dat,'</',$tag,'>';
			   }
			 else  if( $tag == 'logo' )
              echo '<',$tag,'>','http://204.197.244.110/~cnfanews/cnfa-ads/'.$val,'</',$tag,'>';
			   else
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       
}
	   echo '</posts>';
	   
				  }
 }


######################################## End Category ###########################################################
######################################## City wise category-search #############################################################
if( $_GET['action']=='search_all' )
 {

	  if($_GET['ads'])
	  {
		 $rs=mysql_query("select * from ads WHERE ads_desc like '%".$_GET['ads']."%' AND status=1"); 
		
	    $posts = array();
		 $post12 = array();
		 $post13 = array();
	
	 		while( $result=mysql_fetch_assoc($rs))
		{
			//print_r($result);
		
			
			$da=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where city_id='".$result['city']."'"));
			$ds=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$result['city']."'"));
		//$result[]=array("city-name"=>$ds['city_name'],"newspaper-name"=>$da['newspaper_name']);
		$result["city-name"]=$ds['city_name'];
		$result["newspaper_name"]=$da['newspaper_name'];
		//$post12[]=array("city-name"=>$ds['city_name']);
		//$post13[]=array("newspaper-name"=>$da['newspaper_name']);
		
		$posts[]=array("post"=>$result);
		}  
	
	if(!empty($posts))
	{
	   header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			   echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       
       }
       }
	   }
	   echo '</posts>';
	}else
	{
		header('Content-type: text/xml');
       echo '<posts>';
	   echo "Data not Found";
	   echo '</posts>';
		
		}
       
}
	   
	  }


######################################## End Cat-search ###########################################################
######################################## START contact detail #########################################################
if( $_GET['action']=='contact_detail' )
 {
	  //echo  $_GET['action'];
	  //echo $_GET['data'];


	 
		 $posts = array();
		//echo "select id,city_name,status,update_time from cities WHERE city_name like '".$_GET['data']."%'";
		$rs=mysql_query("select * from contact_detail  ");
		
	 	while( $result=mysql_fetch_assoc($rs))
		{
			
		$posts[]=array("post"=>$result);	
		} 
		 
	 
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  
 }
######################################## END contact detail ###########################################################
######################################## Start newspaper wise searching ###########################################################
if( $_GET['action']=='searchbynewspaper' )
 {
	  $newspaper_id=$_GET['newspaper_id'];
	  $text= $_GET['data'];


	 
		 $posts = array();
		$sql=mysql_query("select category_id from category_to_newspaper where  newspaper_id='".$newspaper_id."'");
		if($sql)
		{
       while($val=mysql_fetch_assoc($sql))
	   {
		   
$data=mysql_fetch_assoc(mysql_query("select id,ads_title,ads_desc,city,creation_time,update_time from ads where  category_id='".$val['category_id']."' and ads_desc like '%".$text."%' AND status=1 "));
if($data)
{
 $news=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where id='".$newspaper_id."'"));
 $city=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$data['city']."'"));
		$data['newspaper_name']= $news['newspaper_name']; 
		$data['city_name']= $city['city_name'];

		$posts[]=array("post"=>$data);
}
		}
		}
		
		
		
      		/*$rs=mysql_query("select * from contact_detail  ");
		
	 	while( $result=mysql_fetch_assoc($rs))
		{
			
		$posts[]=array("post"=>$result);	
		} */
		 
	 
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  
 }
######################################## END newspaper wise searching #############################################################
######################################## Start city wise searching ###########################################################
if( $_GET['action']=='searchbycity' )
 {
	  $city_id=$_GET['city_id'];
	  $text= $_GET['data'];


	 
		 $posts = array();
		$news=mysql_fetch_assoc(mysql_query("select id from newspapers where  city_id='".$city_id."' AND status=1"));
		$sql=mysql_query("select category_id from category_to_newspaper where newspaper_id='".$news['id']."'");
       while($val=mysql_fetch_assoc($sql))
	   {
		   
$data=mysql_fetch_assoc(mysql_query("select id,ads_title,ads_desc,city,creation_time,update_time,category_id from ads where  category_id='".$val['category_id']."' and ads_desc like '%".$text."%' and status=1 "));
 $getnewsid=mysql_fetch_assoc(mysql_query("select newspaper_id from category_to_newspaper where id='".$data['category_id']."'"));
 $news=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where id='".$getnewsid['newspaper_id']."' and status=1"));
 $city=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$city_id."' and status=1"));
		$data['newspaper_name']= $news['newspaper_name']; 
		$data['city_name']= $city['city_name'];
		$posts[]=array("post"=>$data);   
		}
		
		
		
      		/*$rs=mysql_query("select * from contact_detail  ");
		
	 	while( $result=mysql_fetch_assoc($rs))
		{
			
		$posts[]=array("post"=>$result);	
		} */
		 
	 
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  
 }
######################################## END city wise searching #############################################################
######################################## Searching Ads  ###############################################################
if( $_GET['action']=='searchads' )
 {
	  $city_id=$_GET['city_id'];
	  $cat_id=$_GET['cat_id'];
	  $news_id=$_GET['news_id'];
	 
	  $text= $_GET['data'];

if(!$city_id)
	{ 
		 $posts = array();
 $news=mysql_fetch_assoc(mysql_query("select newspaper_name,city_id from newspapers where id='".$news_id."' and status=1"));
		$data=mysql_query("select id,ads_title,ads_desc,city,creation_time,update_time,category_id from ads where  category_id='".$cat_id."' and city='".$news['city_id']."' and ads_desc like '%".$text."%' and status=1 ");
       while($val=mysql_fetch_assoc($data))
	   {
 $news=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where city_id='".$news['city_id']."' and status=1"));
 $city=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$val['city']."' status=1"));
		$val['newspaper_name']= $news['newspaper_name']; 
		$val['city_name']= $city['city_name'];
		$posts[]=array("post"=>$val);   
		}
	
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  
 }

else
{
if($city_id)
	{ 
		 $posts = array();
		$data=mysql_query("select id,ads_title,ads_desc,city,creation_time,update_time,category_id from ads where  category_id='".$cat_id."' and city='".$city_id."' and ads_desc like '%".$text."%' and status=1 ");
       while($val=mysql_fetch_assoc($data))
	   {
 $news=mysql_fetch_assoc(mysql_query("select newspaper_name from newspapers where city_id='".$city_id."' and status=1"));
 $city=mysql_fetch_assoc(mysql_query("select city_name from cities where id='".$city_id."' and status=1"));
		$val['newspaper_name']= $news['newspaper_name']; 
		$val['city_name']= $city['city_name'];
		$posts[]=array("post"=>$val);   
		}
		
	    header('Content-type: text/xml');
       echo '<posts>';
       foreach($posts as $index => $post) {
       if(is_array($post)) {
       foreach($post as $key => $value) {
       echo '<',$key,'>';
       if(is_array($value)) {
       foreach($value as $tag => $val)
              
			  echo '<',$tag,'>',$val,'</',$tag,'>';
			  
      
       }
          echo '</',$key,'>';
       }
       }
       }
       echo '</posts>';
				  
 }
 }
 }

######################################## END Searching Ads #############################################################

		  
		ob_flush();	?>