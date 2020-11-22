# awslocal sqs delete-queue --queue-url http://localhost:4566/000000000000/huller_1
# awslocal sqs delete-queue --queue-url http://localhost:4566/000000000000/huller_2
# npm install -g serverless@1.16.0 --force
# cd /api-serverless
# zip -r /tmp/api-serverless.zip /api-serverless
# awslocal lambda create-function --function-name api-serverless --runtime node12.x --handler main --zip-file fileb:///tmp/api-serverless.zip --role admin
# serverless install -u https://github.com/localstack/serverless-examples/tree/master/aws-node-simple-http-endpoint -n aws-node-simple-http-endpoint

# update code
# aws lambda update-function-code \
#     --function-name "dev-$1" \
#     --zip-file "fileb:///docker-entrypoint-initaws.d/lambdas-code/$1/lambda.zip" \
#     --endpoint-url http://localhost:4574

# cd / && zip -qr aws-node-simple-http-endpoint.zip /aws-node-simple-http-endpoint/*
# awslocal lambda create-function \
#     --function-name aws-node-simple-http-endpoint \
#     --runtime nodejs10.x \
#     --role admin \
#     --handler index.handler \
#     --memory-size 512 \
#     --timeout 360 \
#     --zip-file fileb:///aws-node-simple-http-endpoint.zip
# rm aws-node-simple-http-endpoint.zip

# awslocal lambda delete-function --function-name api-serverless 
# Nome da funcao no handler.endpoin
cd /api-serverless && zip -qr -D ../api-serverless.zip * && cd ..
awslocal lambda create-function \
    --function-name api-serverless \
    --runtime nodejs12.x \
    --role admin \
    --handler handler.endpoint \
    --memory-size 512 \
    --timeout 360 \
    --zip-file fileb:///api-serverless.zip
rm api-serverless.zip

# cd /api-redis && npm i && zip -qr -D ../api-redis.zip * && cd ..
# awslocal lambda create-function \
#     --function-name api-redis \
#     --runtime nodejs12.x \
#     --role admin \
#     --handler handler.endpoint \
#     --memory-size 512 \
#     --timeout 360 \
#     --zip-file fileb:///api-redis.zip
# rm api-redis.zip

# awslocal --endpoint-url=http://localhost:4566 lambda invoke --function-name api-serverless /dev/stdout