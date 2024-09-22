module "networking" {
    source = "./module/networking"
    vpc_cidr = "10.0.0.0/16"
    public_subnet_cidr = "10.0.1.0/24"
    private_subnet_cidr = "10.0.2.0/24"
}

module "securitygroup" {
    source = "./module/securitygroup"
    vpc_id = module.networking.vpc_id
}

module "server" {
    source    = "./module/server"
    ami_id    = "ami-0182f373e66f89c85"
    instance_type = "t2.micro"
    public_subnet_id = module.networking.public_subnet_id
    private_subnet_id = module.networking.private_subnet_id
    pub_inst_sg_id = module.securitygroup.pub_inst_sg_id
    priv_inst_sg_id = module.securitygroup.priv_inst_sg_id
}


