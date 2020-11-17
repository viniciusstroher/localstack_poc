#https://gist.github.com/viniciusstroher/e3ae07f268d9488ac3b399df33b07fec
#lambda-name
export API_NAME=api-serverless 
export PATH_NAME=funcao
export STAGE=test

#cria apigateway
awslocal apigateway create-rest-api --name ${API_NAME}

export LAMBDA_ARN=$(awslocal lambda list-functions --query "Functions[?FunctionName==\`${API_NAME}\`].FunctionArn" --output text | cut -f1) 
export API_ID=$(awslocal apigateway get-rest-apis --query "items[?name==\`${API_NAME}\`].id" --output text | cut -f1)
export PARENT_RESOURCE_ID=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/`].id' | cut -f1)

#awslocal apigateway get-rest-apis -> id
#awslocal apigateway get-resources --rest-api-id aydpfr10jm -> parent id
#cria resource
awslocal apigateway create-resource \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part ${PATH_NAME}

export RESOURCE_ID=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/${PATH_NAME}`].id' --output text | cut -f1)

#adicionar resource recem criado
awslocal apigateway put-method \
 --rest-api-id ${API_ID} \
 --resource-id ${RESOURCE_ID} \
 --http-method GET \
 --request-parameters "method.request.path.${PATH_NAME}=true" \
 --authorization-type "NONE"

#anexao ao lambda pegar id do lambda
awslocal apigateway put-integration \
 --region us-east-1 \
 --rest-api-id ${API_ID} \
 --resource-id ${RESOURCE_ID} \
 --http-method GET \
 --type AWS_PROXY \
 --integration-http-method POST \
 --uri arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${LAMBDA_ARN}/invocations \
 --passthrough-behavior WHEN_NO_MATCH

#deploy app
awslocal apigateway create-deployment \
 --rest-api-id ${RESOURCE_ID} \
 --stage-name ${STAGE}

 #access
 #http://localhost:4566/restapis/aydpfr10jm/test/_user_request_/resourceid