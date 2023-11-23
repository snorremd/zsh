# Get directory of current script
mypath=$0:A
mypath=${mypath%/*}

# Source all files matching *-aliases.zsh
for file in $mypath/*-aliases.zsh; do
  source $file
done
