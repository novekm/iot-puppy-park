/* eslint-disable import/no-extraneous-dependencies */
// -- AWS AMPLIFY CONFIGURATION PARAMETERS --

import { Amplify } from 'aws-amplify';
import { AWSIoTProvider } from '@aws-amplify/pubsub';
// eslint-disable-next-line import/no-unresolved
import outputsJSON from '../../../terraform-deployment/modules/bittle-iot-core/outputs.json';

// Apply plugin with configuration - make sure you only declare this once or you will get
// Duplicate messages in IoT Core.
Amplify.addPluggable(
  new AWSIoTProvider({
    aws_pubsub_region: `${outputsJSON.outputs.bc_aws_current_region.value}`,
    aws_pubsub_endpoint: `wss://${outputsJSON.outputs.bc_iot_endpoint.value}/mqtt`,
  })
);

const AmplifyConfig = {
  // Existing API
  API: {
    aws_appsync_graphqlEndpoint:
      outputsJSON.outputs.bc_appsync_graphql_api_uris.value.GRAPHQL, // Replace with your GraphQL Endpoint
    // aws_appsync_graphqlEndpoint: import.meta.env.VITE_GRAPHQL_URL, // Replace with your GraphQL Endpoint
    aws_appsync_region: outputsJSON.outputs.bc_aws_current_region.value, // Replace with the region you deployed CDK with
    // aws_appsync_region: import.meta.env.VITE_REGION, // Replace with the region you deployed CDK with
    aws_appsync_authenticationType: 'AMAZON_COGNITO_USER_POOLS', // No touchy
  },

  // Existing Auth
  Auth: {
    // REQUIRED only for Federated Authentication - Amazon Cognito Identity Pool ID
    identityPoolId: outputsJSON.outputs.bc_identity_pool_id.value,
    // identityPoolId: import.meta.env.VITE_IDENTITY_POOL_ID,

    // REQUIRED - Amazon Cognito Region
    region: outputsJSON.outputs.bc_aws_current_region.value, // Replace with the region you deployed CDK with
    // region: import.meta.VITE_REGION, // Replace with the region you deployed CDK with

    // OPTIONAL - Amazon Cognito Federated Identity Pool Region
    // Required only if it's different from Amazon Cognito Region
    identityPoolRegion: outputsJSON.outputs.bc_aws_current_region.value,
    // identityPoolRegion: import.meta.VITE_REGION,

    // REQUIRED - Amazon Cognito User Pool ID
    userPoolId: outputsJSON.outputs.bc_user_pool_id.value, // Replace with your User Pool ID
    // userPoolId: import.meta.VITE_USER_POOL_ID, // Replace with your User Pool ID

    // REQUIRED - Amazon Cognito Web Client ID (26-char alphanumeric string)
    userPoolWebClientId: outputsJSON.outputs.bc_user_pool_client_id.value, // Replace with your User Pool Web Client ID
    // userPoolWebClientId: import.meta.VITE_APP_CLIENT_ID, // Replace with your User Pool Web Client ID

    // OPTIONAL - Enforce user authentication prior to accessing AWS resources or not
    mandatorySignIn: false,

    // OPTIONAL - Hosted UI configuration
    oauth: {
      domain: 'your_cognito_domain',
      scope: [
        'phone',
        'email',
        'profile',
        'openid',
        'aws.cognito.signin.user.admin',
      ],
      redirectSignIn: 'http://localhost:3000/',
      redirectSignOut: 'http://localhost:3000/',
      responseType: 'code', // or 'token', note that REFRESH token will only be generated when the responseType is code
    },
  },

  Storage: {
    AWSS3: {
      bucket: outputsJSON.outputs.bc_landing_bucket.value, // REQUIRED -  Amazon S3 bucket name
      region: outputsJSON.outputs.bc_aws_current_region.value, // Required -  Amazon service region
      // bucket: import.meta.VITE_LANDING_BUCKET, // REQUIRED -  Amazon S3 bucket name
      // region: import.meta.VITE_REGION, // Required -  Amazon service region
    },
  },
};

export { AmplifyConfig };

// export {existingAPI, existingAuth, existingS3}
