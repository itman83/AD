<?php
session_start();
unset($_SESSION['myusername']);
header("location:../index.php");
?>