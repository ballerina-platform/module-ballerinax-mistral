# Ballerina Mistral AI connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/ci.yml)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/trivy-scan.yml)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-mistral/actions/workflows/build-with-bal-test-graalvm.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-mistral.svg)](https://github.com/ballerina-platform/module-ballerinax-mistral/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/mistral.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%mistral)

## Overview

[Mistral AI](https://chat.mistral.ai/chat?q=) is a research lab focused on developing the best open-source AI models. It provides developers and businesses with powerful [APIs](https://docs.mistral.ai/api/) and tools to build innovative applications using both free and commercial large language models.

## Setup guide

To use the Mistral AI Connector, you must have access to the Mistral AI API through a Mistral AI account and an active API key. If you do not have a Mistral AI account, you can sign up for one [here](https://mistral.ai/)

#### Create a Mistral AI API key

1. Visit the Mistral AI platform, head to the Mistral AI console dashboard, and sign up to get started.

2. Navigate to the API Keys panel.

3. Choose a plan based on your requirements.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/choose-plan.png alt="Mistral AI Platform" style="width: 70%;">

4. Proceed to create a new API key.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/create-key.png alt="Mistral AI Platform" style="width: 70%;">

5. Enter the necessary details as prompted and click on Create new key.
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/details-panel.png alt="Mistral AI Platform" style="width: 70%;">

6. Copy the API key and store it securely
<img src=https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-mistral/main/docs/setup/resources/copy-key.png alt="Mistral AI Platform" style="width: 70%;">

## Quickstart

To use the `Mistaral` connector in your Ballerina application, update the `.bal` as follow: 

### step 1: Import the module

Import the `ballerinax/mistral` module

```ballerina
import ballerinax/mistral;
```

### step 2: Create a new connector instance

Create a mistral:Client with the obtained API Key and initialize the connector.

```ballerina
configurable string token = ?;

mistral:Client mistralClient = check new (
    config = {auth: {token: token}}
);
```

### step 3: Step 3: Invoke the connector operation

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
```ballerina
bal run
```

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`mistral` package](https://central.ballerina.io/ballerinax/mistral/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
