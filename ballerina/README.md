 ## Overview

[Mistral AI](https://chat.mistral.ai/chat?q=) is a research lab focused on developing the best open-source AI models. It provides developers and businesses with powerful [APIs](https://docs.mistral.ai/api/) and tools to build innovative applications using both free and commercial large language models.

The `ballerinax/` offers APIs to connect and interact with the endpoints of Mistral AI API v1, enabling seamless integration with Mistral's language models.

## Setup guide
To use the Mistral AI Connector, you must have access to the Mistral AI API through a Mistral AI account and an active API key. If you do not have a Mistral AI account, you can sign up for one [here](https://mistral.ai/)

#### Create a Mistral AI API key

1. Visit the Mistral AI platform, head to the Mistral AI console dashboard, and sign up to get started.

2. Navigate to the API Keys panel.

3. Choose a plan based on your requirements.
![Mistral AI Platform](docs\setup\resources\choose-plan.png)

4. Proceed to create a new API key.
![Mistral AI Platform](docs\setup\resources\create-key.png)

5. Enter the necessary details as prompted and click on Create new key.
![Mistral AI Platform](docs\setup\resources\details-panel.png)

6. Copy the API key and store it securely
![Mistral AI Platform](docs\setup\resources\copy-key.png)

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