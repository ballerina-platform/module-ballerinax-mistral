 ## Overview

[Mistral AI](https://chat.mistral.ai/chat?q=) is a research lab focused on developing the best open-source AI models. It provides developers and businesses with powerful [APIs](https://docs.mistral.ai/api/) and tools to build innovative applications using both free and commercial large language models.

The `ballerinax/` offers APIs to connect and interact with the endpoints of Mistral AI API v1, enabling seamless integration with Mistral's language models.

## Setup guide
To use the Mistral AI Connector, you must have access to the Mistral AI API through a Mistral AI account and an active API key. If you do not have a Mistral AI account, you can sign up for one [here](https://mistral.ai/)

#### Create a Mistral AI API key

1. Visit the Mistral AI platform, head to the Mistral AI console dashboard, and sign up to get started.

2. Navigate to the API Keys panel.

3. Choose a plan based on your requirements.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/choose-plan.png alt="Mistral AI Platform">

4. Proceed to create a new API key.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/create-key.png alt="Mistral AI Platform">

5. Enter the necessary details as prompted and click on Create new key.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/details-panel.png alt="Mistral AI Platform">

6. Copy the API key and store it securely
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/copy-key.png alt="Mistral AI Platform">

## Quickstart

To use the `Mistaral` connector in your Ballerina application, update the `.bal` as follow: 

### Step 1: Import the module

Import the `ballerinax/mistral` module

```ballerina
import ballerinax/mistral;
```

### Step 2: Create a new connector instance

Create a mistral:Client with the obtained API Key and initialize the connector.

```ballerina
configurable string token = ?;

mistral:Client mistralClient = check new (
    config = {auth: {token: token}}
);
```

### Step 3: Invoke the connector operation

Now, you can utilize available connector operations.

Generate a response for given message
```ballerina
mistral:ChatCompletionRequest request = {
    model: "mistral-small-latest",
    messages: [
        {
            role: "user",
            content: "What is the capital of France?"
        }
    ]
};

mistral:ChatCompletionResponse response = check mistralClient->/chat/completions.post(request);
```
### Step 4: Run the Ballerina application

Execute the command below to run the Ballerina application:

```ballerina
bal run
```