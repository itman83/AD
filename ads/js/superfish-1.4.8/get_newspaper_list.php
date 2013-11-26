<?php
include('config.php');
if( $_POST['nws'] )
{
	//echo "SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id IN (".$_POST['nws']."))";
//	exit();
	$li = '';
$paper = mysql_query("SELECT * FROM category WHERE id IN (SELECT category_id FROM category_to_newspaper WHERE newspaper_id IN (".$_POST['nws']."))");	
while($data = mysql_fetch_array($paper))
{
$li = $li.'<li><input id="'.$data['id'].'" name="search-category[]" type="checkbox" value="'.$data['id'].'">'.$data['category_name'].'</li>';	
}
echo $li;
}
?>