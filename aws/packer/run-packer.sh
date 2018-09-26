packer build \
  -var 'aws_access_key=' \
  -var 'aws_secret_key=' \
  -var 'aws_region=ap-northeast-1' \
  -var 'aws_base_ami=ami-06cd52961ce9f0d85' \
  -var 'spot_price=0.005' \
  ec2-php.json