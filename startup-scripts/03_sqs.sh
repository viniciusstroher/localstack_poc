# awslocal sqs delete-queue --queue-url http://localhost:4566/000000000000/huller_1
# awslocal sqs delete-queue --queue-url http://localhost:4566/000000000000/huller_2
awslocal sqs create-queue --queue-name huller_1
awslocal sqs create-queue --queue-name huller_2
awslocal sqs list-queues