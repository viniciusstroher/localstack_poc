import { ApiGatewayAuthorizer } from 'aws-apigw-authorizer';
const lambdaAuthorizer = new ApiGatewayAuthorizer()
export const handler = lambdaAuthorizer.handler.bind(lambdaAuthorizer);
 