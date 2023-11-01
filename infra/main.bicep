targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the the environment which is used to generate a short unique hash used in all resources.')
param name string

@minLength(1)
@description('Primary location for all resources')
param location string

param adminEmailAddress string
param authGitHubId string
param authRole string?
@secure()
param authGitHubSecret string
param azureAdClientId string
@secure()
param azureAdClientSecret string
param azureAdTenantId string

param nextAuthSecret string

@description('Existing Azure OpenAI instance name (required for existing deployment)')
param openAIInstanceName string?

@description('Existing Azure OpenAI deployment key (required for existing deployment)')
@secure()
param openAIKey string?

// azure open ai
@description('Location for the OpenAI resource group (required for new Azure OpenAI deployment only)')
@allowed([ 'canadaeast', 'eastus', 'francecentral', 'japaneast', 'northcentralus', 'australieast' ])
@metadata({
  azd: {
    type: 'location'
  }
})
param openAILocation string = 'eastus'

param openAISku string = 'S0'
param openAIApiVersion string = '2023-03-15-preview'

param chatGptDeploymentCapacity int = 30
param chatGptDeploymentName string = 'chat-gpt-35-turbo'
param chatGptModelName string = 'gpt-35-turbo'
param chatGptModelVersion string = '0613'
param embeddingDeploymentName string = 'embedding'
param embeddingDeploymentCapacity int = 10
param embeddingModelName string = 'text-embedding-ada-002'

param formRecognizerSkuName string = 'S0'
param searchServiceIndexName string = 'azure-chat'
param searchServiceSkuName string = 'standard'
param searchServiceAPIVersion string = '2023-07-01-Preview'

param resourceGroupName string = ''

var resourceToken = toLower(uniqueString(subscription().id, name, location))
var tags = { 'azd-env-name': name }

// Organize resources in a resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: !empty(resourceGroupName) ? resourceGroupName : 'rg-${name}'
  location: location
  tags: tags
}

module resources 'resources.bicep' = {
  name: 'all-resources'
  scope: rg
  params: {
    name: name
    resourceToken: resourceToken
    tags: tags
    adminEmailAddress: adminEmailAddress
    authRole: authRole
    authGitHubId: authGitHubId
    authGitHubSecret: authGitHubSecret
    azureAdClientId: azureAdClientId
    azureAdClientSecret: azureAdClientSecret
    azureAdTenantId: azureAdTenantId
    openai_api_version: openAIApiVersion
    openAiInstanceName: openAIInstanceName
    openAiKey: empty(openAIKey) ? null : openAIKey
    openAiResourceGroupLocation: openAILocation
    openAiSkuName: openAISku
    chatGptDeploymentCapacity: chatGptDeploymentCapacity
    chatGptDeploymentName: chatGptDeploymentName
    chatGptModelName: chatGptModelName
    chatGptModelVersion: chatGptModelVersion
    embeddingDeploymentName: embeddingDeploymentName
    embeddingDeploymentCapacity: embeddingDeploymentCapacity
    embeddingModelName: embeddingModelName
    formRecognizerSkuName: formRecognizerSkuName
    searchServiceIndexName: searchServiceIndexName
    searchServiceSkuName: searchServiceSkuName
    searchServiceAPIVersion: searchServiceAPIVersion
    location: location
  }
}

// TODO - move constants to .env and secure keys to key store
output ADMIN_EMAIL_ADDRESS string = adminEmailAddress
output APP_URL string = resources.outputs.url
output AUTH_GITHUB_ID string = authGitHubId
output AUTH_GITHUB_SECRET string = authGitHubSecret
output AUTH_ROLE string = authRole
output AZURE_AD_CLIENT_ID string = azureAdClientId
output AZURE_AD_CLIENT_SECRET string = azureAdClientSecret
output AZURE_AD_TENANT_ID string = azureAdTenantId
output AZURE_COSMOSDB_KEY string = resources.outputs.AZURE_COSMOSDB_KEY
output AZURE_COSMOSDB_DB_NAME string = 'chat'
output AZURE_COSMOSDB_CONTAINER_NAME string = 'history'
output AZURE_COSMOSDB_URI string = resources.outputs.AZURE_COSMOSDB_URI
output AZURE_DOCUMENT_INTELLIGENCE_ENDPOINT string = resources.outputs.AZURE_DOCUMENT_INTELLIGENCE_ENDPOINT
output AZURE_DOCUMENT_INTELLIGENCE_KEY string = resources.outputs.AZURE_DOCUMENT_INTELLIGENCE_KEY
output AZURE_LOCATION string = location
output AZURE_OPENAI_API_DEPLOYMENT_NAME string = resources.outputs.AZURE_OPENAI_API_DEPLOYMENT_NAME
output AZURE_OPENAI_API_EMBEDDINGS_DEPLOYMENT_NAME string = resources.outputs.AZURE_OPENAI_API_EMBEDDINGS_DEPLOYMENT_NAME
output AZURE_OPENAI_API_INSTANCE_NAME string = resources.outputs.AZURE_OPENAI_API_INSTANCE_NAME
output AZURE_OPENAI_API_KEY string = resources.outputs.AZURE_OPENAI_API_KEY
output AZURE_OPENAI_API_VERSION string = '2023-03-15-preview'
output AZURE_SEARCH_API_KEY string = resources.outputs.AZURE_SEARCH_API_KEY
output AZURE_SEARCH_API_VERSION string = '2023-07-01-Preview'
output AZURE_SEARCH_INDEX_NAME string = resources.outputs.AZURE_SEARCH_INDEX_NAME
output AZURE_SEARCH_NAME string = resources.outputs.AZURE_SEARCH_NAME
output AZURE_SPEECH_KEY string = resources.outputs.AZURE_SPEECH_KEY
output AZURE_SPEECH_REGION string = resources.outputs.AZURE_SPEECH_REGION
output AZURE_TENANT_ID string = tenant().tenantId
output NEXT_PUBLIC_SPEECH_ENABLED bool = true
output NEXTAUTH_SECRET string = nextAuthSecret
output NEXTAUTH_URL string = 'http://localhost:3000'
