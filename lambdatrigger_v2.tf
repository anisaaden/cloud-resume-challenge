data "archive_file" "python_lambda_package" {  
  type = "zip"  
  source_file = "python/lambda_function_v2.py" 
  output_path = "lambdatrigger_v2.zip"
}