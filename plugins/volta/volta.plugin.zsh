# Set Volta home directory
export VOLTA_HOME="$HOME/.config/volta"

# Create Volta home directory if it doesn't exist
if [[ ! -d "$VOLTA_HOME" ]]; then
  mkdir -p "$VOLTA_HOME"
fi

# Add Volta bin to PATH
export PATH="$VOLTA_HOME/bin:$PATH" 