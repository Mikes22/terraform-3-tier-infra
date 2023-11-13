module "vpc" {
  source = "./vpc"
  tags = local.project_tags
}

module "rds" {
  source = "./rds"
  tags = local.project_tags
  private-subnet1 = module.vpc.private_subnet1_id
  private-subnet2 = module.vpc.private_subnet2_id
  vpc_id = module.vpc.vpc_id
  vpc_cidr = "10.0.0.0/16"
}