aws --endpoint-url=http://localhost:4566 configure set aws_session_token test --profile default
aws --endpoint-url=http://localhost:4566 configure set aws_secret_key test --profile default
aws --endpoint-url=http://localhost:4566 configure set aws_session_token test --profile default

aws --endpoint-url=http://localhost:4566 configure set region us-west-2 --profile default
aws --endpoint-url=http://localhost:4566 configure set output json --profile default