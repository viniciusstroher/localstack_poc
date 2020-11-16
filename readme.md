# Cluster
docker-compose up -> create and start
docker-compose doww -> destroy and stop
docker exec -it localstack-local bash -> access container bash
# Local Client
install (python with pip)
pip install awscli-local (aws local cli)
npm install -g serverless@1.16.0 --force

# Ports
Elasticsearch (port 4571)...
ES service (port 4578)...
S3 server (port 4572)...
SNS server (port 4575)...
SQS server (port 4576)...
API Gateway (port 4567)...
DynamoDB (port 4569)...
DynamoDB Streams (port 4570)...
Starting mock Lambda (port 4574)...
Starting mock Kinesis (port 4568)...

# Access url
http://localhost:9000

# Comands

## Aws login
aws configure list

## Setup local account
aws configure --profile default (client,key: test, region: us-east-1, output format: json)

## Create s3 bucket
awslocal s3 mb s3://huller1 (não usar caracteres especiais)

## list s3 object
awslocal s3 ls s3://huller1 --recursive

## Delete s3 bucket
awslocal s3 mb s3://huller1

## Grant public access s3
awslocal s3api put-bucket-acl --bucket huller1 --acl public-read-write

## List s3
awslocal s3 ls (lista buckets)

## Copy
awslocal s3 cp index.html s3://huller1 --recursive (upload unico vai)
awslocal s3 cp ./ s3://huller1 --recursive

## Create site via s3
awslocal s3 website s3://huller1 --index-document index.html --error-document error.html

# Service discover
http://localhost:4566/health?reload

## Test Url
http://localhost:4566/huller1/index.html (compilar usando homepage no packge.json)
## DynamoDb Admin
http://localhost:8001/

## Lista lambda
awslocal lambda list-functions

## Invoke lambda
awslocal --endpoint-url=http://localhost:4566 lambda invoke --function-name aws-node-simple-http-endpoint /dev/stdout

### Install lambda from repo
cd / && serverless install -u https://github.com/localstack/serverless-examples/tree/master/aws-node-simple-http-endpoint -n /aws-node-simple-http-endpoint

#  Handbook
https://lobster1234.github.io/2017/04/05/working-with-localstack-command-line/

# Serverless example
https://github.com/localstack/serverless-examples