## cloudformation yaml file

* [base](base) 基礎架構
  * [base/sns2slack-node](base/sns2slack-node) sns2slack.yaml 裡的測試原始碼
  * [base/vpc-endpoint.yaml](base/vpc-endpoint.yaml) vpc-endpoint的相關設定
  * [base/default-lambda-policy.yaml](base/default-lambda-policy.yaml) 預設的 lambda 執行所需的 policy
  * [base/sns2slack.yaml](base/sns2slack.yaml) 預設的 sns2slack ，用途如 lambda DLQ、cloudwatch alarm... 預設是 slack channel 為 104corp/sysrd_default
  * [base/travis-ci.yaml](base/travis-ci.yaml) travis-ci 帳號、及所需的相關 policy，需要用的 credentials 則是透過 aws manage console 裡產生

* [slack](slack) 為 slack api 的相關 infrastructure 資訊
  * [slack/slack.yaml](slack/slack.yaml) 目前包含 slack user dynamodb 、slack user cronjob、slack user api 、slack name api

