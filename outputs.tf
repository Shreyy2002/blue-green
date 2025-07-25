output "alb_dns" {
  value = module.alb.alb_dns
}
output "debug_az_to_subnets" {
  value = local.az_to_subnets
}
output "debug_unique_subnet_ids" {
  value = local.unique_subnet_ids
}
output "debug_public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}
output "debug_public_subnet_azs" {
  value = module.vpc.public_subnet_azs
}
