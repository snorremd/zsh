PATH=$PATH:/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin

# Gcloud Proxy to proxy cloud run service to localhost
function gc-proxy() {
  # Get list of and select project
  PROJECTS=$(
    gum spin \
      --spinner line \
      --title "Fetching projects" \
      --show-output \
      -- gcloud projects list --format='csv(project_id,name,project_number)' \
   | sed 's/,/ - /g' \
   | tail -n +2)

  PROJECT=$(echo $PROJECTS | gum filter | cut -d ' ' -f 1)

  # Get list of cloud run services and select one
  SERVICES=$(
    gum spin \
      --spinner line \
      --title "Fetching services" \
      --show-output \
      -- gcloud run services list --project $PROJECT --format='csv(SERVICE,REGION,URL)' \
   | sed 's/,/ - /g' \
   | tail -n +2)
  SERVICE=$(echo $SERVICES | gum filter)
  SERVICE_NAME=$(echo $SERVICE | sed 's/ - /./g' | cut -d '.' -f 1)
  REGION=$(echo $SERVICE | sed 's/ - /./g' | cut -d '.' -f 2)
  PORT=$(gum input --placeholder "Proxy to localhost port:")

  echo "Proxying $SERVICE_NAME to localhost:$PORT for project $PROJECT in region $REGION"

  gcloud beta run services proxy $SERVICE_NAME --port $PORT --project $PROJECT --region $REGION
}


# GCloud SQL Proxy to proxy cloud sql instance to localhost
function gc-sql-proxy() {
  # Get list of and select project
  PROJECTS=$(
    gum spin \
      --spinner line \
      --title "Fetching projects" \
      --show-output \
      -- gcloud projects list --format='csv(project_id,name,project_number)' \
   | sed 's/,/ - /g' \
   | tail -n +2)

  PROJECT=$(echo $PROJECTS | gum filter | cut -d ' ' -f 1)

  # Get list of cloud sql instances and select one
  INSTANCES=$(
    gum spin \
      --spinner line \
      --title "Fetching instances" \
      --show-output \
      -- gcloud sql instances list --project $PROJECT --format='csv(NAME,REGION)' \
   | sed 's/,/ - /g' \
   | tail -n +2)

  INSTANCE=$(echo $INSTANCES | gum filter)

  NAME=$(echo $INSTANCE | sed 's/ - /./g' | cut -d '.' -f 1)
  ID=$(gcloud sql instances describe $NAME --project $PROJECT --format='value(connectionName)')

  echo "Proxying $ID to localhost:5432"

  cloud-sql-proxy $ID
}
