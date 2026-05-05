variable "project_name"      { type = string }
variable "environment"       { type = string }
variable "instance_type"     { type = string }
variable "subnet_id"         { type = string }
variable "security_group_ids" { type = list(string) }
variable "public_key_path"   { type = string }

variable "root_volume_size"  { 
    type = number
    default = 20 
}
# variable "user_data_path"    { 
#     type = string
#     default = "" 
# }