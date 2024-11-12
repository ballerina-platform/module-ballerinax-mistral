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

import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {
    resource function get v1/models() returns ModelList {
      return {
          "object": "list",
          "data": [
            {
            "id": "ministral-3b-2410",
            "object": "model",
            "created": 1731383243,
            "owned_by": "mistralai",
            "name": "ministral-3b-2410",
            "description": "Official ministral-3b-2410 Mistral AI model",
            "max_context_length": 32768,
            "aliases": ["ministral-3b-latest"],
            "capabilities": {
                "completion_chat": true,
                "function_calling": true
            },
            "type": "base"
            },
            {
            "id": "ministral-8b-2410",
            "object": "model",
            "created": 1731383243,
            "owned_by": "mistralai",
            "name": "ministral-8b-2410",
            "description": "Official ministral-8b-2410 Mistral AI model",
            "max_context_length": 32768,
            "aliases": ["ministral-8b-latest"],
            "capabilities": {
                "completion_chat": true,
                "function_calling": true
            },
            "type": "base"
            }]
      };
    }

};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skiping mock server initialization as the tests are running on live server");
        return;
    }
    log:printInfo("Initiating mock server");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}