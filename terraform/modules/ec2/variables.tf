variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "project_name" {
  type    = string
  default = "task-api-assessment"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}
