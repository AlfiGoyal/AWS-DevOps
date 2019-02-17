import boto3
import base64
import os
import json
import re

regexp = re.compile(":table/(.*)$")
table_name = boto3.resource('dynamodb').Table(regexp.search(os.environ['TABLE_NAME']).group(1))
data_final = []

def lambda_handler(event, context):
    for record in event['Records']:
        payload = base64.b64decode(record['kinesis']['data'])  # base64 decode
        my_json = payload.decode("utf-8").replace("'", '"')
        data = json.loads(my_json)
        data_final.append(data)

    with table_name.batch_writer() as batch:
        for i in data_final:
            response = batch.put_item(Item=i)
