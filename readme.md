# Cluster
docker-compose up -> create and start
docker-compose donw -> destroy and stop

# Local Client
install (python with pip)
pip install awscli-local

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
S3-> http://localhost:4566/huller1/index.html