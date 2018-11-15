packer build \
  -var 'aws_access_key=' \
  -var 'aws_secret_key=' \
  -var 'aws_region=ap-northeast-1' \
  -var 'aws_base_ami=ami-00f9d04b3b3092052' \
  ec2-php.json