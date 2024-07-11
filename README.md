初期構築手順    
1.S3バケットを手動で作成    
2.tfbackendファイルのバケット名を作成したバケット名に変更する    
3.以下のコマンドでinit    

dev環境    
terraform init -reconfigure -backend-config=_dev.tfbackend    

prod環境    
terraform init -reconfigure -backend-config=_prod.tfbackend    

4.以下のコマンドでplan、apply    
dev環境    
terraform plan -var-file=_dev.tfvars    

prod環境    
terraform plan -var-file=_prod.tfvars   

※ECSのサービス起動前にECRを作成してDockerイメージをpushする    
※デプロイが動くたびにLBに紐づけているターゲットグループが変更されるのでTerraformで差分として検知する    

ECS周り構築手順    
1.VPC    
2.サブネット、NAT    
3.ルートテーブル、ルートテーブルアタッチ    
4.セキュリティグループ    
5.ロードバランサー、ターゲットグループ    
6.CodeCommit    
7.ECR   
8.ECSクラスター    
9.タスク起動用IAMロール      
10.タスク起動用IAMロールへのポリシー割り当て    
11.Cloud9を起動してECRにbuildしたイメージをpushする    
12.タスク定義、Cloudwatch logs    
13.ECSサービス    
14.ALB経由でコンテナに接続できることを確認    

CICD関連構築手順    
1.コードデプロイアプリケーション    
2.コードデプロイ用IAMロールの定義、ポリシーアタッチ    
3.デプロイグループ    
4.Cloud9からCodeCommitにcontainerフォルダをpushする    
※masterブランチでcontainerフォルダ配下にDockrefile等を含める    
※taskdef.jsonとbuildspec.ymlの${ACCOUNT_ID}をAWSアカウントIDに置き換える    
5.CodeBuild、CodeBuild用ロール    
6.CodePipeline    
7.コードを修正してcodecommitにpushしてCICDが動くことを確認    

<img width="925" alt="image" src="https://github.com/19951023Taa/terraform_ecs_cicd/assets/84821891/8091095f-ff9c-408c-986f-cfa3d4618289">
