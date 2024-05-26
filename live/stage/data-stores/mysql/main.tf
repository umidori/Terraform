provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "example_database"

  # このユーザ名とパスワードはどのように設定すべきか？
  username = var.db_username
  password = var.db_password
}

terraform {
  backend "s3" {
    # バケット名は自分のものに置き換えること
    bucket = "terraform-up-and-running-state-tori5"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-northeast-1"

    # DynamoDB テーブル名は自分のものに置き換えること
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
