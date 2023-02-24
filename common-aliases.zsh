function fuzzy() {
  EDITOR="${1:-code}"
  $EDITOR $(gum filter)
}

eval $(thefuck --alias)
