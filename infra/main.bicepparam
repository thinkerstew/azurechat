using 'main.bicep'

param name = readEnvironmentVariable('AZURE_ENV_NAME')

param location = readEnvironmentVariable('AZURE_LOCATION')

// Update your admin email addresses - comma separated
param adminEmailAddress = readEnvironmentVariable('ADMIN_EMAIL_ADDRESS')

// Identity provider is optional if you are running in development mode locally (npm run dev)
param authGitHubId = readEnvironmentVariable('AUTH_GITHUB_ID')
param authGitHubSecret = readEnvironmentVariable('AUTH_GITHUB_SECRET')

param azureAdClientId = readEnvironmentVariable('AZURE_AD_CLIENT_ID')
param azureAdClientSecret = readEnvironmentVariable('AZURE_AD_CLIENT_SECRET')
param azureAdTenantId = readEnvironmentVariable('AZURE_AD_TENANT_ID')

// Update your Azure OpenAI details

// deployment name from your azure openai studio
param chatGptDeploymentName = readEnvironmentVariable('AZURE_OPENAI_API_DEPLOYMENT_NAME', 'chat-gpt-35-turbo')
// model name from your azure openai studio
param chatGptModelVersion = readEnvironmentVariable('AZURE_OPENAI_API_MODEL_VERSION', '0613')
// embedding deployment name from your openai studio
param embeddingDeploymentName = readEnvironmentVariable('AZURE_OPENAI_API_EMBEDDINGS_DEPLOYMENT_NAME', 'embedding')
// Supported versions checkout docs https://learn.microsoft.com/en-us/azure/ai-services/openai/reference
param openAIApiVersion = readEnvironmentVariable('AZURE_OPENAI_API_VERSION', '2023-03-15-preview')
// name of azure openai resource and not the full url
param openAIInstanceName = readEnvironmentVariable('AZURE_OPENAI_API_INSTANCE_NAME')
// access key
param openAIKey = readEnvironmentVariable('AZURE_OPENAI_API_KEY', '')

// Update your production Next.js auth secret
param nextAuthSecret = readEnvironmentVariable('NEXTAUTH_SECRET')
