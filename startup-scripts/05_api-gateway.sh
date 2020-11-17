#https://gist.github.com/viniciusstroher/e3ae07f268d9488ac3b399df33b07fec
awslocal apigateway create-rest-api  --name api1
#awslocal apigateway get-rest-apis -> id
#awslocal apigateway get-resources --rest-api-id aydpfr10jm -> parent id
#cria resource
awslocal apigateway create-resource \
    --rest-api-id aydpfr10jm \
    --parent-id jy1q8wtzhm \
    --path-part "resourceid"

#adicionar resource recem criado
awslocal apigateway put-method \
 --rest-api-id aydpfr10jm \
 --resource-id yfsxjkgcrb \
 --http-method GET \
 --request-parameters "method.request.path.somethingId=true" \
 --authorization-type "NONE"

#anexao ao lambda pegar id do lambda
awslocal apigateway put-integration \
 --region us-east-1 \
 --rest-api-id aydpfr10jm \
 --resource-id yfsxjkgcrb \
 --http-method GET \
 --type AWS_PROXY \
 --integration-http-method POST \
 --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:api-serverless/invocations \
 --passthrough-behavior WHEN_NO_MATCH

#deploy app
awslocal apigateway create-deployment \
 --rest-api-id aydpfr10jm \
 --stage-name test

 #access
 #http://localhost:4566/restapis/aydpfr10jm/test/_user_request_/resourceid