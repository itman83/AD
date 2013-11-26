<?php
 require_once('recaptchalib.php');
  $privatekey = "6LfMHuISAAAAAEhMyGpcvQt_GfnOIpipnsqu6r7U";
 $resp = recaptcha_check_answer ($privatekey,
                               $_SERVER["REMOTE_ADDR"],
                               $_POST["capt1"],
                               $_POST["capt"]);
 
 if (!$resp->is_valid) {
   // What happens when the CAPTCHA was entered incorrectly
   echo "0";
 } else {

// Your code here to handle a successful verification

$your_email ='mairaj.saifi@search-value.com';// <<=== update to your email address

$name = $_POST['name'];
$email = $_POST['email'];
$subject = $_POST['subject'];
$message = $_POST['message'];

//$url_page = "http://67.222.6.109/~tsearch/new/algoworks/".$_POST['ipd'];
	///------------Do Validations-------------
	

	
//send the email
$to = $your_email;
$subject="Contact Us";
$from = "mairaj.saifi@search-value.com";
$headers = 'From: CNFA ADS <'.$from.'>'."\r\n";
$ip = isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : '';

$body = "A user submitted the contact form:\n\n".
"Name: $name\n\n".
"Email: $email\n\n".
"Subject: $subject\n\n".
"Message: $message\n\n";

$body1 = "Dear  $name \n\n". "Thanks for submitting your query. We will be getting back to you very soon after processing your query. \n\n".
//"IP: $ip\n";
//"Please click on below link:\n\n".$url_page."\n\nRegards,\Algoworks";



mail($email, $subject, $body1,$headers);
if(mail($to, $subject, $body,$headers))
{
echo "1";
}
else 
{
echo "0";
}
}
?>