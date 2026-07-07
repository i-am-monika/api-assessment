module "vpc" {
  source = "./modules/vpc"

  project_name = "task-api-assessment"
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_ids[0]
  project_name = "task-api-assessment"
}
