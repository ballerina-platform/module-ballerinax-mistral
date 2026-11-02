// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/data.jsondata;
import ballerina/io;
import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("isLiveServer") == "false";
configurable string token = isLiveServer ? os:getEnv("mistralToken") : "test";

final string mockServiceUrl = "http://localhost:9090";
final Client mistralAiClient = check initClient();

function initClient() returns Client|error {
    io:println("isLiveServer: ", isLiveServer);
    if isLiveServer {
        return new ({auth: {token}});
    }
    return new ({auth: {token}}, mockServiceUrl);
}

@test:Config {
    groups: ["mock_tests"],
    enable: !isLiveServer
}
isolated function testChatCompletion() returns error? {
    UserMessage userMessage = {
        role: "user",
        content: "This is a test message"
    };

    ChatCompletionRequest chatRequest = {
        messages: [userMessage],
        model: "mistral-small-latest"
    };

    io:println("Sending chat completion request: ", chatRequest);

    ChatCompletionResponse response = check mistralAiClient->/chat/completions.post(chatRequest);
    io:println("Server response: ", response);
    ChatCompletionChoice[]? choices = response.choices;
    if choices is ChatCompletionChoice[] {
        AssistantMessage? message = choices[0].message;
        string|ContentChunk[]? content = message?.content;
        test:assertEquals(content, "Test message received! How can I assist you today?");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: !isLiveServer
}
isolated function testChatCompletionWithThinkingChunks() returns error? {
    ChatCompletionRequest chatRequest = {
        messages: [{role: "user", content: "What is 2 + 3?"}],
        model: "mistral-large-4-0",
        reasoningEffort: "high"
    };

    ChatCompletionResponse response = check mistralAiClient->/chat/completions.post(chatRequest);
    ChatCompletionChoice[]? choices = response.choices;
    if choices is () {
        return error("Expected choices in the response");
    }
    string|ContentChunk[]? content = choices[0].message?.content;
    if content !is ContentChunk[] {
        return error("Expected the content to be a list of chunks");
    }
    test:assertEquals(content.length(), 2);
    ContentChunk thinkingChunk = content[0];
    if thinkingChunk !is ThinkChunk {
        return error("Expected the first chunk to be a thinking chunk");
    }
    test:assertEquals(thinkingChunk.thinking, [{'type: "text", text: "The user wants the sum of 2 and 3."}]);
    test:assertEquals(content[1], {'type: "text", text: "2 + 3 = 5"});
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testReasoningEffortSerialization() {
    ChatCompletionRequest chatRequest = {
        messages: [{role: "user", content: "Hi"}],
        model: "mistral-small-2603",
        reasoningEffort: "none"
    };
    json payload = jsondata:toJson(chatRequest);
    if payload !is map<json> {
        test:assertFail("Expected a JSON object");
    }
    test:assertEquals(payload["reasoning_effort"], "none");
    test:assertFalse(payload.hasKey("reasoningEffort"));
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testThinkChunkSerialization() {
    AssistantMessage message = {
        content: [
            {thinking: [{text: "Reasoning trace"}]},
            {text: "Final answer"}
        ]
    };
    test:assertEquals(jsondata:toJson(message), {
        "role": "assistant",
        "prefix": false,
        "content": [
            {"type": "thinking", "thinking": [{"text": "Reasoning trace", "type": "text"}], "closed": true},
            {"text": "Final answer", "type": "text"}
        ]
    });
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}

isolated function listModels() returns error? {
    ModelList response = check mistralAiClient->/models.get();

    json jsonResp;
    if isLiveServer {
        (BaseModelCard|FTModelCard)[]? modelListData = response?.data;
        if modelListData is () {
            return error("Failed to get model list data");
        }
        BaseModelCard|FTModelCard baseModel = modelListData[0];
        if baseModel is BaseModelCard {
            baseModel.created = 1742277940;
        } else {
            return error("Failed to get base model data");
        }
        jsonResp = jsondata:toJson(baseModel);

    } else {
        jsonResp = jsondata:toJson(response);
    }

    if isLiveServer {
        decimal temperature = 0.3;
        json expectedLiveServerValue = {
            "id": "ministral-3b-2410",
            "object": "model",
            "created": 1742277940,
            "owned_by": "mistralai",
            "capabilities": {
                "classification": false,
                "completion_chat": true,
                "completion_fim": false,
                "function_calling": true,
                "fine_tuning": true,
                "vision": false
            },
            "name": "ministral-3b-2410",
            "description": "Official ministral-3b-2410 Mistral AI model",
            "max_context_length": 131072,
            "aliases": [
                "ministral-3b-latest"
            ],
            "deprecation": null,
            "default_model_temperature": temperature,
            "type": "base"
        };
        test:assertEquals(jsonResp, expectedLiveServerValue);
    } else {
        json expectedResponse = {
            "object": "list",
            "data": [
                {
                    "id": "ministral-3b-2410",
                    "object": "model",
                    "owned_by": "mistralai",
                    "capabilities": {
                        "completion_chat": true,
                        "completion_fim": false,
                        "function_calling": true,
                        "fine_tuning": false,
                        "vision": false
                    },
                    "max_context_length": 32768,
                    "aliases": [
                        "ministral-3b-latest"
                    ],
                    "type": "base"
                },
                {
                    "id": "ministral-3b-latest",
                    "object": "model",
                    "owned_by": "mistralai",
                    "capabilities": {
                        "completion_chat": true,
                        "completion_fim": false,
                        "function_calling": true,
                        "fine_tuning": false,
                        "vision": false
                    },
                    "max_context_length": 32768,
                    "aliases": [
                        "ministral-3b-2410"
                    ],
                    "type": "base"
                }
            ]
        };
        test:assertEquals(jsonResp, expectedResponse);
    }

}
