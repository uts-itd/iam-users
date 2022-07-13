# iam-users

## Example of an complete use case
The following code will provide you're AWS environment with users:

 - user-1
 - user-2

via tfvars. Both will have their *credentials saved in AWS Secrets Manager*.
To achieve this, please take a look at the following code:

### Example main.tf

    module "users" {
      source            = "git@github.com:terraform-cloud-aws-modules/iam-users.git"
      users             = var.users
    }

### Example variables.tf

    variable "users" {
      type              = map
    }

### Example outputs.tf

    output "user_arns" {
      value             = module.users.user_arns
    }
    
    output "user_ids" {
      value             = module.users.user_ids
    }

### Example common.tfvars

    users = {
      "user-1" = {
        path            = "/"
        force_destroy   = true
      }
      "user-2" = {
        path            = "/"
        force_destroy   = true
      }
    }

