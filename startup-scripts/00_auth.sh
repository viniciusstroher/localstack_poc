aws --endpoint-url=http://localhost:4566 configure set access_key test --profile default
aws --endpoint-url=http://localhost:4566 configure set secret_key test --profile default
aws --endpoint-url=http://localhost:4566 configure set region us-west-2 --profile default
aws --endpoint-url=http://localhost:4566 configure set output json --profile default
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test