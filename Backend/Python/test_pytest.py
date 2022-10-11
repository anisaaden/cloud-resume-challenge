import requests

def test_get_visitor_count():
    response = requests.get("https://wkvkeb54y5.execute-api.us-east-1.amazonaws.com/dev/lambda_function_CRC")
    response_body = response.json()
    assert response.status_code == 200
 