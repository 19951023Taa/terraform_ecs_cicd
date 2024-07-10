subnet_cidrs = {
  public_subnet_a_01  = { cidr_block = "10.0.1.0/24", az = "ap-northeast-1a", }
  public_subnet_c_01  = { cidr_block = "10.0.2.0/24", az = "ap-northeast-1c", }
  private_subnet_a_01 = { cidr_block = "10.0.3.0/24", az = "ap-northeast-1a", }
  private_subnet_c_01 = { cidr_block = "10.0.4.0/24", az = "ap-northeast-1c", }
}

#TEST用で普段使用してない
rds_password = "test-password"