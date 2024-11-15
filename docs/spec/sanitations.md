_Author_:  Thiunuwan \
_Created_: 11/07/2024 \
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Mistral AI. 
The OpenAPI specification is obtained from [Mistral AI OpenAPI specification](https://docs.mistral.ai/redocusaurus/plugin-redoc-0.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

[//]: # (TODO: Add sanitation details)
1. **Removed Dash Prefix**: Updated `$ref` reference for `EmbeddingResponseData` schema.
   - **Before**: `- $ref: "#/components/schemas/EmbeddingResponseData"`
   - **After**: `$ref: "#/components/schemas/EmbeddingResponseData"` 
2. 
3. 

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2024, change if necessary.
