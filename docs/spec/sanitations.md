_Authors_:  @aakifAhamed \
_Reviewers_: @daneshk @ThisaruGuruge @TharmiganK 
_Created_: 2025/05/21 \
_Updated_: 2026/11/02 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification
1. Add support for reasoning models to the chat completion API.
   - Added the `ThinkChunk` schema (`type: thinking`) and included it in the `ContentChunk` union and discriminator mapping, so that responses of reasoning models (e.g. `mistral-large-4-0`, `mistral-small-2603`) containing thinking content can be parsed.
   - Added the `ReasoningEffort` enum schema and the `reasoning_effort` property to the `ChatCompletionRequest` schema.

   These additions are aligned with the latest [Mistral AI OpenAPI specification](https://docs.mistral.ai/openapi.yaml).

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client -o ballerina
```