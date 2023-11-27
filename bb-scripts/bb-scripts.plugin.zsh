# Check that bb command exists
if ! command -v bb &> /dev/null
then
    echo "Could not load bb-scripts zsh plugin"
    echo "bb command could not be found"
    echo "Please install babashka: https://github.com/babashka/babashka#installation"
    return
fi

# Add bb scripts to path
mypath=$0:A
mypath=${mypath%/*}


export PATH="$PATH:$mypath"
