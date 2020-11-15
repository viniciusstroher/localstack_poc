awslocal s3 rm s3://huller1
awslocal s3 mb s3://huller1
awslocal s3api put-bucket-acl --bucket huller1 --acl public-read-write
awslocal s3 cp D:\WebstormProjects\ionic-huller-app\hullerApp\build s3://huller1 --recursive