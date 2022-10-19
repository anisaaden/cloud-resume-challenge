data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "${path.module}/Python/lambda_function_v2.py" 
  output_path = "lambdatrigger_v2.zip"
}
