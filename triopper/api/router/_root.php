<?php

// /root con
$controller = new Controller();

// /system con 00
$system_con = new Controller();

// /user con 01
$user_con = new Controller();

// /trip con 02
$trip_con = new Controller();

// /
$controller->register("System",$system_con);
$controller->register("User",$user_con);
$controller->register("Trip",$trip_con);

// /user/subscribe
$subscribe_con = new Controller();


?>