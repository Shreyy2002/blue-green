module "vpc" {
  source         = "./modules/vpc"
  cidr_block     = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "sg" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "blue_ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  instance_count    = 1
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.sg.security_group_id
  key_name          = var.key_name
  name_prefix       = "blue"
}

module "green_ec2" {
  source            = "./modules/ec2"
  ami_id            = var.ami_id
  instance_type     = "t2.micro"
  instance_count    = 1
  subnet_id         = module.vpc.public_subnet_ids[1]
  security_group_id = module.sg.security_group_id
  key_name          = var.key_name
  name_prefix       = "green"
}

module "alb" {
  source            = "./modules/alb"
  subnet_ids        = module.vpc.public_subnet_ids
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
