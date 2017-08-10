#!/bin/bash

# system update
echo "system update..."
sudo yum -y update

# php install
echo "install example program..."
sudo yum -y install httpd php
# sudo mkdir -p /var/www/html
sudo sh -c "echo \"v1<hr><?php echo gethostname(); ?><hr><?php echo gethostbyname(gethostname()); ?>\" > /var/www/html/index.php"
sudo sh -c "echo \"<?php\" >> /var/www/html/pi.php"
sudo sh -c "echo \" \" >> /var/www/html/pi.php"
sudo sh -c "echo \"for ($a=0; $a <2; $a++){\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  $pi = 4; $top = 4; $bot = 3; $minus = TRUE;\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  $accuracy = 100000000;\" >> /var/www/html/pi.php"
sudo sh -c "echo \"\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  for($i = 0; $i < $accuracy; $i++)\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  {\" >> /var/www/html/pi.php"
sudo sh -c "echo \"    $pi += ( $minus ? -($top/$bot) : ($top/$bot) );\" >> /var/www/html/pi.php"
sudo sh -c "echo \"    $minus = ( $minus ? FALSE : TRUE);\" >> /var/www/html/pi.php"
sudo sh -c "echo \"    $bot += 2;\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  }\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  print 'Pi ~=: ' . $pi;\" >> /var/www/html/pi.php"
sudo sh -c "echo \"  print '<br>';\" >> /var/www/html/pi.php"
sudo sh -c "echo \"}\" >> /var/www/html/pi.php"
sudo sh -c "echo \"?>\" >> /var/www/html/pi.php"
sudo service httpd start
sudo chkconfig httpd on

# install code deploy agent
echo "install aws codedeploy..."
wget https://aws-codedeploy-ap-northeast-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
