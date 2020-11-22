"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.handler = void 0;

var _awsApigwAuthorizer = require("aws-apigw-authorizer");

var lambdaAuthorizer = new _awsApigwAuthorizer.ApiGatewayAuthorizer(); // use the authorizers handler as the lambda handler function:

var handler = lambdaAuthorizer.handler.bind(lambdaAuthorizer);
exports.handler = handler;