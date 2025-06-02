# Running Tests

## Prerequisites

You need an API token from Mistral AI.

To obtain this, refer to the [Ballerina Mistral connector](https://github.com/ballerina-platform/module-ballerinax-mistral/blob/main/ballerina/Module.md).

## Test Environments

There are two test environments for running the `mistral` connector tests. The default environment is a mock server. The other environment is the actual Mistral API

You can run the tests in either of these environments, and each has its own compatible set of tests.

| Test Groups | Environment                                       |
|-------------|---------------------------------------------------|
| mock_tests  | Mock server for Mistral API (Default Environment)  |
| live_tests  | Mistral API                                        |

## Running Tests in the Mock Server

To execute the tests on the mock server, ensure that the `isLiveServer` environment variable is either set to `false` or left unset before initiating the tests.

This environment variable can be configured within the `Config.toml` file located in the `tests` directory or specified as an environment variable.

### Using a `Config.toml` File

Create a `Config.toml` file in the `tests` directory with the following content:

```toml
isLiveServer = false
```

### Using Environment Variables

Alternatively, you can set the environment variable directly.

For Linux or macOS:

```bash
export isLiveServer=false
```

For Windows:

```bash
setx isLiveServer false
```

Then, run the following command to execute the tests:

```bash
./gradlew clean test
```

## Running Tests Against the OpenAI Live API

### Using a `Config.toml` File

Create a `Config.toml` file in the `tests` directory and add your authentication credentials:

```toml
isLiveServer = true
token = "<your-mistral-api-token>"
```

### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables.

For Linux or macOS:

```bash
export isLiveServer=true
export mistralToken="<your-mistral-api-token>"
```

For Windows:

```bash
setx isLiveServer true
setx mistralToken <your-mistral-api-token>
```

Then, run the following command to execute the tests:

```bash
./gradlew clean test
```