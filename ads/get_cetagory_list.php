<?php
include('config.php');
if( $_POST['cty'] )
{
	$li = '';
 $paper = mysql_query(" select  id,newspaper_name FROM newspapers where  status=1 AND city_id IN (".$_POST['cty'].")");
//$paper = mysql_query("SELECT id,newspaper_name FROM newspapers WHERE id IN (SELECT newspaper_id FROM category_to_newspaper WHERE ID IN (SELECT category_id FROM ads WHERE city IN (".$_POST['cty']."))) AND status=1");	
while($data = mysql_fetch_array($paper))
{
$li = $li.'<li><input onclick="get_newspaper_list();" name="search-news[]" type="checkbox" value="'.$data['id'].'">'.$data['newspaper_name'].'</li>';	
}
echo $li;
}
?>