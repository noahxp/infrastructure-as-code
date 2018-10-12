packer build \
  -var 'aws_access_key=' \
  -var 'aws_secret_key=' \
  -var 'aws_region=ap-northeast-1' \
  -var 'aws_base_ami=ami-04d3eb2e1993f679b' \
  ec2-php.json