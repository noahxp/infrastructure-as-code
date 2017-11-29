## cloudformation yaml file

* 基礎架構
  * 建立順序應為 vpc -> sns2slack，[asg][asg.yaml]及[asg-scaling-policy](asg-scaling-policy.yaml)應在 alb 後設定，其他視需要建立
  * [vpc](vpc.yaml) 基礎 vpc 設定，包含 1 個 vpc, 2 個 public subnet, 4 個 private subnet, 及對 s3 與 dynamodb 的 vpc-endpoint (2017-10後，vpc-endpoint有支援新的資源，為 private interface ，此example尚未包含)
  * [sns2slack](sns2slack.yaml) 基礎 sns2slack 設定，包含 1 個 sns topic 及 1 個 slack lambda function ，可用在 notification to slack
  * [natgateway](natgateway.yaml) 基礎 nat-gateway 設定，包含 2 個 nat-gateway 及 所需的 eip 與 nat-subnet over nat-gateway 的 route table
  * [bastion](bastion.yaml) Bastion 設定，包含 1 台 ec2 當 bastion 機及 所需的 security group，需先備好 ec2 keypair 方能在起 bastion server 時即把 ssh key 放進去
  * [alb](alb.yaml) Application Load Balancer(ALB) 設定，可設定是提供給 ECS 使用，還是 EC2 使用，並可指定 EC2/ECS 是放在 private subnet 1 還是 private subnet 2 ，會設定對映的 security group .
  * [asg][asg.yaml] Auto Scaling Group 及 Launch Configuration 與 EC2 所擁有的 IAM Role
  * [asg-scaling-policy](asg-scaling-policy.yaml) ASG 用的 ScalingPolicy，範例中提供三種 scaling 方式 : Simple Scaling , Step Scaling , Scheduled Action

* 其他資源
  * [awslogs](awslogs) aws logs agent configuration example file
  * [cloudwatch](cloudwatch) aws cloudwatch metric
  * [packer-example](packer-example) packer example
  * [reference](reference) 從各地 clone 過來的參考資料