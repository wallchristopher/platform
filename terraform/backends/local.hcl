bucket                      = "platform-floci-terraform-state"
key                         = "local/platform.tfstate"
region                      = "us-east-1"
profile                     = "floci"
use_lockfile                = false
use_path_style              = true
skip_credentials_validation = true
skip_metadata_api_check     = true
skip_requesting_account_id  = true

endpoints = {
  s3 = "http://127.0.0.1:4567"
}
