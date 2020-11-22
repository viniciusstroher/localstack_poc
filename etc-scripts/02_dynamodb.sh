# awslocal s3 rm s3://huller1
# awslocal s3 mb s3://huller1
# awslocal s3api put-bucket-acl --bucket huller1 --acl public-read-write
# awslocal s3 cp /app-to-upload s3://huller1 --recursive
awslocal dynamodb create-table --cli-input-json file:///dynamodb-tables/customer.json
# awslocal dynamodb create-table --cli-input-json file:///dynamodb-tables/products.json
# awslocal dynamodb create-table --cli-input-json file:///dynamodb-tables/order.json
