# Petoi Bittle - IoT Puppy Park! 🐶🐾
#### Created by:
[Kevon Mayers](https://www.linkedin.com/in/kevonmayers)
**TODO - add other contributors and their linkedin profiles**


![Petoi Bittle Image](resources/petio-bittle-image.jpg)

This project is meant to serve as an example of how you can connect a fleet of Petoi Bittles to AWS. If you're not familiar with **[Petoi Bittle](https://www.petoi.com/pages/bittle-open-source-bionic-robot-dog?utm_source=google-ads&utm_campaign=&utm_agid=141849525757&utm_term=&gclid=CjwKCAiA_vKeBhAdEiwAFb_nrQYeIL6zf0sH8S0_gRDafo5FqLmbhOD-LMhOhvEq_o5zeaInmnawqBoCe98QAvD_BwE)**, it is a palm-sized, servo-activated quadruped robot dog. It's board (NyBoard) is a based on an Arduino Uno. There are a number of modules you can connect to Bittle, and a main one we are leveraging is the **[ESP8266](https://docs.petoi.com/communication-modules/wifi-esp8266)**. While Bittle comes with a web and mobile app that you can use the included Bluetooth module to issue commands, we have extended upon this to connect Bittle to AWS for added functionality.

We have connected Bittle to **[AWS IoT Core](https://aws.amazon.com/iot-core/)** and have created a serverless full stack **[AWS Amplify](https://aws.amazon.com/amplify/)** App to control Bittle, as well as view live video and other device information for not just one Bittle, but ***an entire fleet of Bittles***. To provide a streamlined and repeatable deployment, we are leveraging **[Terraform](https://www.terraform.io/)** for Infrastructure as Code (IaC). If you are not too familiar with Terraform, don't worry - we have created a custom Terraform module to abstract away most of the complexity down to a few lines of code. For those more experienced with Terraform, feel free to customize and add on to this solution, we are making it completely open-source.

 For getting started quickly, check out some of our provided **[code examples](http://google.com)**. Support for **[AWS Cloud Development Kit (CDK)](https://aws.amazon.com/cdk/)** and **[AWS CloudFormation](https://aws.amazon.com/cloudformation/)** may come at a later date if there is enough interest.

 ## 🛠 What you will build!

**TODO - Add architecture here**
<!-- ![Amplify IaC architectural diagram](resources/architecture/IAC_SAMPLE_ARCH.png) -->

By using this solution, you will be able to connect one or multiple Petoi Bittles to AWS IoT core, and control them via MQTT messages, as well as view live video streams and other device data through a full stack serverless AWS Amplify Application.

**TODO - Add screenshots of AWS Amplify App**


The Amplify App is leveraging [Cloudscape](https://cloudscape.design/) an open-source React component library released by AWS. If it looks familiar to you, it is because the AWS Console is built with it.
![Cloudscape Homepage](resources/cloudscape-website.png)
## AWS Service List
**TODO - Update these, they are subject to change**
There are a number of AWS services used in this solution including:
- **[Amazon S3](https://aws.amazon.com/s3/)** - IoT Data storage
- **[Amazon DynamoDB](https://aws.amazon.com/dynamodb/)** - Bittle Device Metadata
- **[AWS AppSync](https://aws.amazon.com/appsync/)** - GraphQL API
- **[AWS Amplify](https://aws.amazon.com/amplify/)** - Full stack serverless web application
- **[AWS CodeCommit](https://aws.amazon.com/codecommit/)** - Git repository
- **[Amazon Cognito](https://aws.amazon.com/cognito/)** - Web app/API authentication/authorization
- **[Amazon EventBridge](https://aws.amazon.com/eventbridge/)** - Aggregation of notifications to trigger the Step Function
- **[Amazon IAM](https://aws.amazon.com/iam/)** - Security access control
- **[AWS Step Functions](https://aws.amazon.com/step-functions/)** - Low-code orchestration of data pipeline
- **[AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html)** - secure, hierarchical storage for configuration data and secrets management


**Did You Know?** You can use Infrastructure as Code (IaC) with AWS Amplify for automated deployments at scale with multiple team members. To do this we are leveraging the **[AWS Amplify Libraries for JavaScript](https://docs.amplify.aws/lib/q/platform/js/)** - open-source client libraries that provide use-case centric, opinionated, declarative, and easy-to-use interfaces across different categories of cloud powered operations enabling mobile and web developers to easily interact with their backends.
Here are some of the things you can add to your app by using the client libraries:
- [Authentication](https://docs.amplify.aws/lib/auth/getting-started/q/platform/js/)
- [DataStore](https://docs.amplify.aws/lib/datastore/getting-started/q/platform/js/)
- [User File Storage](https://docs.amplify.aws/lib/storage/getting-started/q/platform/js/)
- [Geo](https://docs.amplify.aws/lib/geo/getting-started/q/platform/js/)
- [Serverless APIs](https://docs.amplify.aws/lib/graphqlapi/getting-started/q/platform/js/)
- [Analytics](https://docs.amplify.aws/lib/analytics/getting-started/q/platform/js/)
- [AI/ML](https://docs.amplify.aws/lib/predictions/getting-started/q/platform/js/)
- [PubSub](https://docs.amplify.aws/lib/pubsub/getting-started/q/platform/js/)
- [AR/VR](https://docs.amplify.aws/lib/xr/getting-started/q/platform/js/)

To send/receive MQTT messages, we are leveraging the **PubSub** component of the client libraries.


## 🎒 Prerequisites
By using this solution, it is assumed that you have a general understanding of the following:
- Amazon Web Services
- Arduino/Microcontroller programming with Arduino IDE
- Petoi Bittle


### Customizing Deployment

As mentioned, there are a number of **optional variables** exposed through the module that allow you to customize the deployment with optional parameters. One example of this is the AWS Amplify App. Feel free to use this, or leverage your own application if you'd like. However, some variables are **required** to satisfy the core goal of this solution. See the **[README](terraform-deployment/examples/README.md)** and **[Terraform Examples Documentation](terraform-deployment/examples/README.md)** in the **`terraform-deployment`** directory for more information.

**Note:** Throughout the solution, the naming convention will include the phrase **`bc`** for most resources. Ex. `bc-graphql-api`. This stands for **Bittle Connect** and is meant to serve as an easy way to determine which resources are related to this solution in your AWS account. Despite this, we still ***highly*** recommend you deploy this in a fresh AWS account with no production workloads.


#### 🚀 Resources to be Deployed
**AWS Amplify**
- Web Application (Optional)
  - `iot-bittle-control-app`

**AWS AppSync**
- GraphQL API
  - `bc-graphql-api`

**AWS CodeCommit**
- Repository (Optional)
  - `bc_codecommit_repo`

**Amazon Cognito**
- `bc_user_pool`
- `bc_identity_pool`
- `bc_user_pool_client`
- `bc_admin_cognito_user_group`
- `bc_admin_cognito_users` (dynamic)
- `bc_standard_cognito_user_group`
- `bc_admin_cognito_users` (dynamic)

**Amazon DynamoDB**
- Table
  - `bc_output`

**Amazon EventBridge**
- Event Bus
  - `bc_event_bus`
- Event Rule
  - `default_event_bus_to_bc_event_bus`
  - `bc_landing_bucket_object_created`

**AWS IAM**
- Roles
  - `bc_amplify_codecommit`
  - `bc_appsync_dynamodb_restricted_access`
  - `bc_cognito_admin_group_restricted_access`
  - `bc_cognito_authrole_restricted_access`
  - `bc_cognito_standard_group_restricted_access`
  - `bc_cognito_unauthrole_restricted_access`
  - `bc_eventbridge_invoke_custom_sample_event_bus_restricted_access`
  - `bc_eventbridge_invoke_sfn_state_machine_restricted_access`
  - `bc_step_functions_master_restricted_access`
- Policies
  - `bc_s3_restricted_access_policy`
  - `bc_dynamodb_restricted_access_policy`
  - `bc_dynamodb_restricted_access_read_only_policy`
  - `bc_ssm_restricted_access_policy`
  - `bc_eventbridge_invoke_custom_sample_event_bus_restricted_access_policy`
  - `bc_eventbridge_invoke_sfn_state_machine_restricted_access_policy`
  - `bc_gitlab_mirroring_policy` (conditional)
- Users
  - `bc_gitlab_mirroring` (conditional)

**Amazon S3**
- Buckets
  - `bc_landing_bucket`
  - `bc_input_bucket`
  - `bc_output_bucket`
  - `bc_app_storage_bucket`


**AWS Systems Manager Parameter Store**
- SSM Parameter
  - `ssm_github_access_token` (conditional)
  - `bc_input_bucket_name`
  - `bc_output_bucket_name`
  - `bc_app_storage_bucket_name`
  - `bc_dynamodb_output_table_name`

**Step Functions**
- State Machine
  - `bc-state-machine`

<!-- ### Data Pipeline

The data pipeline is an event-driven **AWS Step Functions Workflow** triggered by each upload to the **Landing S3 bucket**. Leveraging **Amazon EventBridge**, when a file matching the supported file type is uploaded to the Landing Bucket, the Step Functions Workflow will be triggered. The data pipeline performs the following functions:

1. **Data Ingestion**: The data will be ingested into the S3 Landing bucket. The landing bucket has a bucket policy that restricts file upload to certain specific file types that can be modified as you desire. This reduces the messages going to EventBridge as the EventBridge rule is set to only be used on **`S3:PutObject`** operations. If the file attempted to being uploaded is not a supported file type, the upload will fail and the notification will not be sent to EventBridge. This also means the Step Functions State Machine will not be invoked unless a supported file type is uploaded, reducing potential errors and the number of concurrent Step Functions State Machines running.

2. **Data Preparation**: If the file uploaded matches one of the supported file types, the S3 PutObject notifications will be sent to **EventBridge** and the **Step Function State Machine** will be invoked. The first step will fetch the file from the **S3 Landing bucket**, add a **UUID (Universally Unique Identifier)** to the object key (S3 file name), and copy the file to the Input bucket and App Storage bucket. For this simple example a UUID is not required, however we added it for extensibility - many S3 services you may want to integrate this with (Amazon Transcribe, Amazon Textract, etc.) require a unique ID for each job. The UUID being used is the **`id`** in the S3 PutObject log. This can also be used for **data lineage** because the same **`id`** present in the log for the original file upload will be in the file name as the file goes through the data pipeline.
3. **Data Processing**: Once the file is copied to the Input bucket with the generated UUID, and this is where you could extend this to other AWS services. Perhaps when you upload a file to S3 and it is copied to the input bucket with the necessary UUID, an Amazon Transcribe job is started. For now, the next step is just simulated and the file is copied on to the app storage bucket.
4. **Data Publishing**: If the file was successfully copied between the buckets, the original S3 object metadata will be written to theDynamoDB Table.

Review the [Step Function Workflow](resources/step-function/sample-step-function-workflow.png) for a visual aid.
![TCA architectural diagram](resources/step-function/sample-step-function-workflow.png)

**NOTE:** *To optimize costs, there is an [S3 Lifecycle Rule](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-lifecycle-mgmt.html) present on the **Landing Bucket**, and **Input Bucket**. By default, the rule will expire all objects in the buckets after 24 hours. The necessary data will still be retained however - the media file in the **App Storage Bucket** and the `JSON` data in the DynamoDB table. To modify this, you may disable or modify the lifecycle rules. They are accessible via [Terraform variables](https://www.terraform.io/language/values/variables). Additional costs may apply for removing these rules. For instructions, reference the [sample-module documentation](/terraform-deployment/modules/sample-module/README.md).* If you want to leverage Quicksight, you can modify the Step Function to also copy the `JSON` data from the **Output Bucket** to the optional **Quicksight Bucket**. However, the sample web application has native dashboarding support by leveraging [Cloudscape Design Components](https://cloudscape.design/), so this is not enabled by default. See a demo of an example of an example dashboard [here](https://cloudscape.design/examples/react/dashboard.html?). -->

### AWS AppSync GraphQL API

A pre-built AWS **AppSync GraphQL API** provides flexible querying for application integration. This GraphQL API is authorized using **Amazon Cognito User Pools** and comes with predefined **Admin** and **Standard** roles. These roles are attached to the respective **Cognito User Pool Groups**. Users added to these groups will be able to assume the attached IAM role. This GraphQL API is used for integration with the **IoT Bittle Connect Web Application**.


### AWS Amplify - IoT Bittle Connect Web Application

An AWS Amplify application is deployed and hosted with Amplify Hosting. This is **enabled by default** as it is the intended use of this project, however, you can disable this and connect the backend resources to your own web application if you wish. For more information on the IoT Bittle Connect Amplify Application, see the **[IoT Bittle Connect Web App Documentation](./sample-amplify-app/documentation/README.md)**.


<!-- ### Sample Data Collection for Testing

This project comes with sample data for testing successful deployment of the application and can be found in the **`resources/sample-media`** directory. -->

## 💲 Cost and Licenses

You are responsible for the cost of the AWS services used while running this leveraging this solution. There is no additional cost for using this solution.


The custom Terraform module used for this solution includes configuration parameters that you can customize. Some of these settings can affect the cost of deployment. For cost estimates, see the pricing pages for each AWS service you use. Prices are subject to change.

**Tip:** After you deploy the solution, create [AWS Cost and Usage Reports](https://docs.aws.amazon.com/cur/latest/userguide/what-is-cur.html) to track costs associated with the Quick Start. These reports deliver billing metrics to an S3 bucket in your account. They provide cost estimates based on usage throughout each month and aggregate the data at the end of the month. You can also use [AWS Budgets](https://aws.amazon.com/aws-cost-management/aws-budgets/) to set custom budgets to track your costs and usage, and respond quickly to alerts received from email or SNS notifications if you exceed your threshold. For more information, see [What are AWS Cost and Usage Reports?](https://docs.aws.amazon.com/cur/latest/userguide/what-is-cur.html) and the [AWS Budgets](https://aws.amazon.com/aws-cost-management/aws-budgets/) page.

This solution doesn’t require any software license or AWS Marketplace subscription.

## How to Deploy - CHOOSE YOUR OWN ADVENTURE! 🚀

As mentioned earlier, you can deploy this sample project using either [Terraform](https://www.terraform.io/) or *(coming at a later date)* [AWS Cloud Development Kit (CDK)](https://aws.amazon.com/cdk/). We recommend use of VS Code and the AWS CLI. We also generally recommend a fresh AWS account that can be integrated with your existing infrastructure using AWS Organizations.

[Terraform Deployment Instructions](/terraform-deployment/README.md)
<!-- [AWS CDK Deployment Instructions](/cdk-deployment/README.md) -->

## 👀 See also

- [AWS Energy & Utilities](https://aws.amazon.com/energy/)


