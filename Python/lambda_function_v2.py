import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('MyCRCtable')

def lambda_handler(event, context):
#get the record_id record from the table
#then get the visitor_count value for the record 
#then increment the visitor_count by 1 each time the function is triggered
#finally print visitor_count

    response = table.get_item(Key={
       'record_id':'visitors'
    })
    
    visitor_count = response['Item']['visitor_count']
    visitor_count = visitor_count + 1
    print(visitor_count)

#next we need to put the new visitor count into the table 

    response = table.put_item(Item={
            'record_id':'visitors',
            'visitor_count': visitor_count
    })
    
    response = {
      'statusCode': 200,
      'body': visitor_count,
      'headers' : {
        'Access-Control-Allow-Origin': '*'
      }
              
            }
  
    return response