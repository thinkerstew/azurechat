using 'main.bicep'

param name = 'dev'

param location = 'REPLACE_ME'

// Update your admin email addresses - comma separated
param adminEmailAddress = 'REPLACE_ME'

// Identity provider is optional if you are running in development mode locally (npm run dev)
param authGitHubId = 'REPLACE_ME'
param authGitHubSecret = 'REPLACE_ME'

param azureAdClientId = 'REPLACE_ME'
param azureAdClientSecret = 'REPLACE_ME'
param azureAdTenantId = 'REPLACE_ME'

// Update your Azure OpenAI details

// deployment name from your azure openai studio
param chatGptDeploymentName = 'REPLACE_ME'
// model name from your azure openai studio
param chatGptModelVersion = 'REPLACE_ME'
// embedding deployment name from your openai studio
param embeddingDeploymentName = 'REPLACE_ME'
// Supported versions checkout docs https://learn.microsoft.com/en-us/azure/ai-services/openai/reference
param openAIApiVersion = 'REPLACE_ME'
// name of azure openai resource and not the full url
param openAIInstanceName = 'REPLACE_ME'
// access key
param openAIKey = 'REPLACE_ME'

// Update your production Next.js auth secret
param nextAuthSecret = 'AZURE-OPENIAI-NEXTAUTH-OWNKEY@1'
