<?php
$host   = "localhost";
$user   = "root";
$pass   = "";
$db     = "selinap";

$koneksi = new mysqli("$host", "$user", "$pass", "$db");
if (mysqli_connect_error())
  {
  echo "Waduh error gan :( </br> " . mysqli_connect_error();
  }
  error_reporting(E_ALL ^ (E_NOTICE | E_WARNING));
?>
