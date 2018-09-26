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
    -var 'spot_price=0.005' \
    ec2-php.json
@2018-04 , THE_LASTEST_AMI is : ami-28ddc154
eof


# system update
sudo yum -y update

# php install
sudo yum -y install httpd php
sudo echo "<?php echo gethostname(); ?>" > /var/www/html/index.php
sudo service httpd start
sudo chkconfig httpd on

# install code deploy agent
wget https://aws-codedeploy-us-west-2.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
