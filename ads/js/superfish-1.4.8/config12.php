<?php
$mysql_hostname = "localhost";
$mysql_user = "cnfanews";
$mysql_password = "Search@123";
$mysql_database = "cnfanews_ads";
$prefix = "";
$bd = mysql_connect($mysql_hostname, $mysql_user, $mysql_password) or die("Could not connect database");
mysql_select_db($mysql_database, $bd) or die("Could not select database");
 mysql_query("SET character_set_results = 'utf8', character_set_client = 'utf8', character_set_connection = 'utf8', character_set_database = 'utf8', character_set_server = 'utf8'");

mysql_query("SET NAMES 'UTF8'");
//mysql_set_charset('utf8', $bd);

?>