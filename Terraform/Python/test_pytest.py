import requests

def test_get_visitor_count_check_status_code_equals_200():
     response = requests.get("https://wkvkeb54y5.execute-api.us-east-1.amazonaws.com/dev/lambda_function_CRC")
     assert response.status_code == 200