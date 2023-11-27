# Add bb scripts to path
mypath=$0:A
mypath=${mypath%/*}

export PATH="$PATH:$mypath"
