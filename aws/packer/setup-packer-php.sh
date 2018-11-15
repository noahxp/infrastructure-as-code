#!/bin/bash

:<<eof
base image type : Amazon Linux AMI 2018.03.0 (HVM), SSD Volume Type
AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY variables for get s3 resource
The build script :
./packer build \
    -var 'aws_access_key=ACCESS_KEY' \
    -var 'aws_secret_key=SECRET_KEY' \
    -var 'aws_region=ap-northeast-1' \
    -var 'aws_base_ami=THE_LASTEST_AMI' \
    ec2-php.json
@2018-10 , THE_LASTEST_AMI 2 is : ami-04d3eb2e1993f679b
eof

set -e

# system update
sudo yum -y update

# php install
sudo yum -y install httpd php
#sudo echo "<?php echo gethostname(); ?>" > /var/www/html/index.php
sudo tee /var/www/html/index.php <<EOF
<?php echo gethostname(); ?>
EOF
sudo tee /var/www/html/pi.php <<EOF
<!DOCTYPE html>
<html>
<head>
<style>
body {
    background: #555;
    text-align:center;
}
</style>
</head>
<body>
<?php
\$start = microtime(true);
print gethostname();
print "<hr>\n";

\$pi = 4; \$top = 4; \$bot = 3; \$minus = TRUE;
\$accuracy = 10000000;
for(\$i = 0; \$i < \$accuracy; \$i++)
{
  \$pi += ( \$minus ? -(\$top/\$bot) : (\$top/\$bot) );
  \$minus = ( \$minus ? FALSE : TRUE);
  \$bot += 2;
}
print "Pi ~=: " . \$pi;
print "<hr>\n";

phpinfo();
?>
</body>
</html>
EOF

sudo service httpd start
sudo chkconfig httpd on

# install code deploy agent
sudo yum -y install ruby
curl -o install https://aws-codedeploy-ap-northeast-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
