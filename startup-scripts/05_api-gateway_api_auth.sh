#https://gist.github.com/viniciusstroher/e3ae07f268d9488ac3b399df33b07fec
set -x #echo on
#lambda-name

API_NAME=api-auth 
PATH_NAME=auth
STAGE=test

echo ""
echo "API_NAME $API_NAME "
echo "PATH_NAME $PATH_NAME"
echo "STAGE $STAGE"
echo ""

#cria apigateway
echo ""
echo "Run create-rest-api "
echo ""

awslocal apigateway create-rest-api --name ${API_NAME}

LAMBDA_ARN=$(awslocal lambda list-functions --query "Functions[?FunctionName==\`${API_NAME}\`].FunctionArn" --output text | cut -f1) 
API_ID=$(awslocal apigateway get-rest-apis --query "items[?name==\`${API_NAME}\`].id" --output text | cut -f1)
PARENT_RESOURCE_ID=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query 'items[?path==`/`].id' | tr '"' ' ' | tr "[" " " | tr "]" " ")

echo ""
echo "LAMBDA_ARN $LAMBDA_ARN "
echo "API_ID $API_ID"
echo "PARENT_RESOURCE_ID $PARENT_RESOURCE_ID"
echo ""

echo ""
echo "Run create-resource "
echo ""
awslocal apigateway create-resource \
    --rest-api-id ${API_ID} \
    --parent-id ${PARENT_RESOURCE_ID} \
    --path-part ${PATH_NAME}

RESOURCE_ID=$(awslocal apigateway get-resources --rest-api-id ${API_ID} --query "items[?path=='/${PATH_NAME}'].id" --output text | cut -f1)
echo ""
echo "RESOURCE_ID $RESOURCE_ID "
echo ""

echo ""
echo "Run put-method "
echo ""

#adicionar resource recem criado
#https://docs.aws.amazon.com/cli/latest/reference/apigateway/put-method.html
awslocal apigateway put-method \
 --rest-api-id ${API_ID} \
 --resource-id ${RESOURCE_ID} \
 --http-method GET \
 --authorization-type "NONE"
#  --request-parameters "method.request.path.${PATH_NAME}=true" \

echo ""
echo "Run put-integration "
echo ""
URI=arn:aws:apigateway:us-east-1:lambda:path/system/functions/${LAMBDA_ARN}/invocations
#anexao ao lambda pegar id do lambda
awslocal apigateway put-integration \
 --region us-east-1 \
 --rest-api-id ${API_ID} \
 --resource-id ${RESOURCE_ID} \
 --http-method GET \
 --type AWS_PROXY \
 --integration-http-method POST \
 --uri ${URI} \
 --passthrough-behavior WHEN_NO_MATCH


echo ""
echo "Run create-deployment "
echo ""
#deploy app
awslocal apigateway create-deployment \
 --rest-api-id ${API_ID} \
 --stage-name ${STAGE}

echo ""
echo "Run create-authorizer "
echo ""
awslocal apigateway create-authorizer --rest-api-id ${API_ID} --name CUSTOM_AUTH --type TOKEN --authorizer-uri ${URI} --identity-source method.request.header.Authorization --authorizer-result-ttl-in-seconds 300
export AUTHORIZER_API=$(awslocal apigateway get-authorizers  --rest-api-id ${API_ID} --query "items[?name=='/${CUSTOM_AUTH}'].id" --output text | cut -f1)
#  #access
echo ""
echo "Run create-authorizer "
echo $AUTHORIZER_API
echo ""
#  
echo "http://localhost:4566/restapis/${API_ID}/test/_user_request_/${PATH_NAME}"
# "http://localhost:4566/restapis/${API_ID}/test/_user_request_/${PATH_NAME} \n" >> /docker 