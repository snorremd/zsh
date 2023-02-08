PATH=$PATH:/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin

# Gcloud Proxy to proxy cloud run service to localhost
function gc-proxy() {
  # Get list of and select project
  PROJECTS=$(gum spin --spinner line --title "Fetching projects" --show-output -- gcloud projects list --format='csv(project_id,name,project_number)' | sed 's/,/ - /g')
  PROJECT=$(echo $PROJECTS | gum filter | cut -d ' ' -f 1)
  
  # Get list of cloud run services and select one
  SERVICES=$(gum spin --spinner line --title "Fetching services" --show-output -- gcloud run services list --project $PROJECT --format='csv(SERVICE,URL)' | sed 's/,/ - /g')
  SERVICE_URL=$(echo $SERVICES | gum filter | cut -d ' ' -f 3)
  PORT=$(gum input --placeholder "Proxy to localhost port:")
  cloud-run-proxy -host $SERVICE_URL -bind localhost:$PORT
}
