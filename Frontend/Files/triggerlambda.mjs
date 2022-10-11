fetch("https://wkvkeb54y5.execute-api.us-east-1.amazonaws.com/dev/lambda_function_CRC")
.then(response => response.json())
.then(data => {
        document.getElementById('replaceme').innerText = data
})
