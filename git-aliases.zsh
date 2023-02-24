# Git create branch, bubble choice between conventional commit types
function git-cb() {
  TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert")

  # Pre-populate the input with the type(scope): so that the user may change it
  NAME=$(gum input --value "$TYPE/" --placeholder "Name of this branch")

  # Commit these changes
  gum confirm "Create branch? $NAME" && git checkout -b "$NAME"
}

# Git Clean branches, multichoice with main deselected by default
function git-cl() {
  # List all branches and space separate them
  BRANCHES=$(git branch | grep -v HEAD | sed 's/[\*\s]*//' | tr -d ' ' | sort -u)
  PRESELECTED=$(echo $BRANCHES | grep -v main | tr '\n' ',')

  # Print selector
  TO_DELETE="$(echo $BRANCHES | gum choose --no-limit --selected $PRESELECTED)"

  # Delete branches with gum confirmation
  echo $TO_DELETE | awk '{print " — " $0}' | gum style --foreground 212 --margin "2 0 1 0"
  gum confirm "Delete branches?" && git branch -d `echo $TO_DELETE | tr '\n' ' '`
}

# Git checkout branch using gum filter (fuzzy search)
function git-co() {
  BRANCHES=$(git branch | grep -v HEAD | sed 's/[\*\s]*//' | tr -d ' ' | sort -u)

  # Gum filter branches
  BRANCH=$(echo $BRANCHES | gum filter)

  # Checkout branch
  git checkout $BRANCH
}
