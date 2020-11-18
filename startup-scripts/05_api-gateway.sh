#https://gist.github.com/viniciusstroher/e3ae07f268d9488ac3b399df33b07fec
set -x #echo on
#lambda-name

API_NAME=api-serverless 
PATH_NAME=funcao
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

#awslocal apigateway get-rest-apis -> id
#awslocal apigateway get-resources --rest-api-id aydpfr10jm -> parent id
#cria resource

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
awslocal apigateway put-method \
 --rest-api-id ${API_ID} \
 --resource-id ${RESOURCE_ID} \
 --http-method GET \
 --authorization-type "NONE"
#  --request-parameters "method.request.path.${PATH_NAME}=true" \

echo ""
echo "Run put-integration "
echo ""
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

echo ""
echo "Run create-deployment "
echo ""
#deploy app
awslocal apigateway create-deployment \
 --rest-api-id ${API_ID} \
 --stage-name ${STAGE}

#  #access
#  #http://localhost:4566/restapis/aydpfr10jm/test/_user_request_/resourceid