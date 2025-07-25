module "vpc" {
  source             = "./modules/vpc"
  cidr_block         = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_azs  = ["ap-southeast-1a", "ap-southeast-1b"]  # <-- distinct AZs
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "blue_ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  instance_count    = var.instance_count
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.sg.security_group_id
  key_name          = var.key_name
  name_prefix       = "blue"
  user_data_path    = "${path.root}/scripts/user-data.sh"
}

module "green_ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  instance_count    = var.instance_count
  subnet_id         = module.vpc.public_subnet_ids[1]
  security_group_id = module.sg.security_group_id
  key_name          = var.key_name
  name_prefix       = "green"
  user_data_path    = "${path.root}/scripts/user-data.sh"
}

locals {
  az_to_subnets = {
    for idx, az in module.vpc.public_subnet_azs :
    az => flatten([
      for i, candidate_az in module.vpc.public_subnet_azs :
      candidate_az == az ? [module.vpc.public_subnet_ids[i]] : []
    ])...
  }

  unique_subnet_ids = [
    for az, subnets in local.az_to_subnets : compact(flatten(subnets))[0]
  ]
}



module "alb" {
  source            = "./modules/alb"
  subnet_ids        = local.unique_subnet_ids
  security_group_id = module.sg.security_group_id
  tg_name           = "blue-green-tg"
  vpc_id            = module.vpc.vpc_id
}

module "attach_blue" {
  source           = "./modules/alb_attachment"
  instance_ids     = module.blue_ec2.instance_ids
  target_group_arn = module.alb.target_group_arn
}

module "attach_green" {
  source           = "./modules/alb_attachment"
  instance_ids     = module.green_ec2.instance_ids
  target_group_arn = module.alb.target_group_arn
}
