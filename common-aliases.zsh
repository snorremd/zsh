function fuzzy() {
  EDITOR="${1:-code}"
  $EDITOR $(gum filter)
}
