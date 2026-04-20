provider "aws" {
  region = "us-east-1"
}

# 1. VPC Configuration
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = { Name = "eks-vpc" }
}

# 2. Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# 3. Public Subnets (For Load Balancers)
resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = ["10.0.1.0/24", "10.0.2.0/24"][count.index]
  availability_zone       = ["us-east-1a", "us-east-1b"][count.index]
  map_public_ip_on_launch = true
  tags                    = { Name = "public-${count.index + 1}" }
}

# 4. Private Subnets (For Worker Nodes)
resource "aws_subnet" "private" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = ["10.0.3.0/24", "10.0.4.0/24"][count.index]
  availability_zone = ["us-east-1a", "us-east-1b"][count.index]
  tags              = { Name = "private-${count.index + 1}" }
}

# 5. EKS Cluster using the official module
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "my-eks-cluster-v2"
  cluster_version = "1.29"

  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private[*].id

  eks_managed_node_groups = {
    workers = {
      min_size       = 2
      max_size       = 2
      desired_size   = 2
      instance_types = ["t3.medium"]
    }
  }
}
