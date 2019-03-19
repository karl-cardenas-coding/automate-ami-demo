import json
import boto3
import os

from botocore.vendored import requests
from base64 import b64decode


projectId  = os.environ['projectId']
token = os.environ['token']
tokenDecrypted = boto3.client('kms').decrypt(CiphertextBlob=b64decode(token))['Plaintext'].decode("utf-8")



def lambda_handler(event, context):
    try:
        r = requests.post('https://gitlab.com/api/v4/projects/%s/ref/master/trigger/pipeline?token=%s'%(projectId,tokenDecrypted))
        return {
            'statusCode': r.status_code,
            'body': r.text
        }
    except:
        print(json.dumps('The event object: ' + str(event)))
