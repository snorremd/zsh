# Check that bb command exists
if ! command -v gum &> /dev/null
then
    echo "Could not load aliases zsh plugin"
    echo "gum command could not be found"
    echo "Please install gum: https://github.com/charmbracelet/gum"
    return
fi

# Get directory of current script
mypath=$0:A
mypath=${mypath%/*}

# Source all files matching *-aliases.zsh
for file in $mypath/*-aliases.zsh; do
  source $file
done
