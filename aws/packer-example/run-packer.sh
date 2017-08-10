packer build \
    -var 'aws_access_key=' \
    -var 'aws_secret_key=' \
    -var 'aws_region=ap-northeast-1' \
    -var 'aws_base_ami=ami-3bd3c45c' \
    ec2-php.json
