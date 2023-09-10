# If the resticprofile command is unavailable, we can't do anything
if (( ! $+commands[resticprofile] )); then
  echo "resticprofile: command not found"
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `resticprofile`. Otherwise, compinit will have already done that
if [[ ! -f "$ZSH_CACHE_DIR/completions/_resticprofile" ]]; then
  typeset -g -A _comps
  autoload -Uz _resticprofile
  _comps[resticprofile]=_resticprofile
fi

# Load the completion file for `resticprofile` in the background
resticprofile generate --zsh-completion >| "$ZSH_CACHE_DIR/completions/_resticprofile" &|
