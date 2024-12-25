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


# Convert wav files to other audio formats
function convert_audio() {
    local input="$1"
    local basename="${input:r}"
    
    ffmpeg -i "$input" \
           -c:a flac "${basename}.flac" \
           -c:a libmp3lame -qscale:a 2 "${basename}.mp3" \
           -c:a libvorbis -qscale:a 4 "${basename}.ogg" \
           -c:a aac -b:a 192k "${basename}.m4a"
}

# Create an alias to the function
alias convert_audio='convert_audio'