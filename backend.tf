terraform {
  backend "s3" {
		# Replace this with your bucket name!
		bucket = "tflab-backend"
		# Define the object key for the terraform state!
		key = "tflab01/terraform.tfstate"
		region = "ap-southeast-1"
		# Replace this with your DynamoDB table name!
		dynamodb_table = "tflab-backend-locks"
		encrypt = true
	}
}