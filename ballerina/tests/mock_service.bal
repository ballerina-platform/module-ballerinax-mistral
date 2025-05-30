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

import ballerina/http;

service / on new http:Listener(9090) {
    resource function post chat/completions(map<json> payload) returns ChatCompletionResponse|http:BadRequest {
        AssistantMessage message = {
            role: "assistant",
            tool_calls: null,
            content: "Test message received! How can I assist you today?",
            prefix: false
        };

        ChatCompletionChoice choice = {
            finish_reason: "stop",
            index: 0,
            message: message
        };

        // Mock response
        ChatCompletionResponse response = {
            id: "chatcmpl-1234abcd",
            model: "mistral-7b-instruct",
            'object: "chat.completion",
            usage: {completion_tokens: 16, prompt_tokens: 34, total_tokens: 50},
            choices: [
                choice
            ],
            created: 1702256327
        };
        return response;
    }

    resource function get models() returns ModelList|error {
        ModelCapabilities modelCapabilities = {
            completion_chat: true,
            function_calling: true,
            vision: false,
            fine_tuning: false,
            completion_fim: false
        };

        BaseModelCard baseModel1 = {
            id: "ministral-3b-2410",
            capabilities: modelCapabilities,
            aliases: ["ministral-3b-latest"]
        };

        BaseModelCard baseModel2 = {
            id: "ministral-3b-latest",
            capabilities: modelCapabilities,
            aliases: ["ministral-3b-2410"]
        };

        ModelList models = {
            'object: "list",
            data: [baseModel1, baseModel2]
        };

        return models;
    }
};
