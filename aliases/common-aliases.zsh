function fuzzy() {
  EDITOR="${1:-code}"
  $EDITOR $(gum filter)
}

function port-to-pid {
	lsof -nP -iTCP -sTCP:LISTEN | grep $1 | tr -s ' ' | cut -d" " -f2
}

function kill-by-port {
	kill -9 $(port-to-pid $1)
}

eval $(thefuck --alias)
