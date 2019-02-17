import base64
import json


def lambda_handler(event, context):
    for record in event['Records']:
        # Kinesis data is base64 encoded so decode here
        payload = base64.b64decode(record["kinesis"]["data"])
        resp = json.loads(payload)
        print ("id:" + resp['id'] + ",x:" + resp['x'] + ",y:" + resp['y'])
