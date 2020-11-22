cd /api-auth/ && npm i aws-apigw-authorizer --save && npm i --save-dev @babel/cli @babel/core @babel/preset-env && npm run build && zip -qr -D ../api-auth.zip * && cd ..
# --handler handler.endpoint \ usando o do babel
awslocal lambda create-function \
    --function-name api-auth \
    --runtime nodejs12.x \
    --role admin \
    --handler handler_es6.endpoint \
    --memory-size 512 \
    --timeout 360 \
    --environment Variables={NODE_OPTIONS="--experimental-modules"} \
    --zip-file fileb:///api-auth.zip
rm api-auth.zip
# awslocal --endpoint-url=http://localhost:4566 lambda invoke --function-name api-auth /dev/stdout