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

# Comands
awslocal kinesis list-streams

## Create s3 bucket
awslocal s3 mb s3://huller1 (não usar caracteres especiais)

## List s3
awslocal s3 ls (lista buckets)

## Copy
aws s3 cp filename.txt s3://bucketname1
aws s3 cp s3://bucketname1 s3://bucketname2
aws s3 cp ./ s3://huller1 --recursive

## Create site via s3
awslocal s3 website s3://huller1 --index-document index.html --error-document error.html
