_Author_:  Thiunuwan \
_Created_: 11/07/2024 \
_Updated_: <!-- TODO: Add date --> \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Mistral AI. 

These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **Removed Dash Prefix**: Updated `$ref` reference for `EmbeddingResponseData` schema.
   - **Before**: `- $ref: "#/components/schemas/EmbeddingResponseData"`
   - **After**: `$ref: "#/components/schemas/EmbeddingResponseData"`
   In the OpenAPI Specification (OAS), the dash (-) prefix is used to indicate an array item within a list.However, if the $ref is being directly assigned to a property and not part of an array, the dash prefix is unnecessary

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client --license docs/license.txt -o ballerina
```
Note: The license year is hardcoded to 2024, change if necessary.
