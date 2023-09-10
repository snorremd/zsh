# If the rustic command is unavailable, we can't do anything
if (( ! $+commands[rustic] )); then
  echo "rustic: command not found"
  return
fi

# If the completion file doesn't exist yet, we need to autoload it and
# bind it to `rustic`. Otherwise, compinit will have already done that
if [[ ! -f "$ZSH_CACHE_DIR/completions/_rustic" ]]; then
  typeset -g -A _comps
  autoload -Uz _rustic
  _comps[rustic]=_rustic
fi

# Load the completion file for `rustic` in the background
rustic completions zsh >| "$ZSH_CACHE_DIR/completions/_rustic" &|
