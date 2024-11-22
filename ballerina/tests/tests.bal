// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/os;

// Define configurable variables for the connector setup
configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string mistralApiKey = isLiveServer ? os:getEnv("MISTRAL_APIKEY") : "test";
configurable string mistralServiceUrl = isLiveServer ? "https://api.mistral.ai" : "http://localhost:9090";

// Initialize the Mistral client with authentication and service URL
ConnectionConfig mistralConfig = {auth: {token: mistralApiKey}};
final Client mistral = check new Client(mistralConfig, mistralServiceUrl);


// Test to get models in Mistral
@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetModels() returns error? {
    ModelList response = check mistral->/v1/models.get;
    test:assertTrue(response?.data !is (), msg = "Failed to retrieve models list");
}

