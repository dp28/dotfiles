todo() {
  layer append -t default -k todo -v "$@"
}

todone() {
  layer remove -t default -k "todo[$(($1 - 1))]"
}

notify() {
  local now=`date +%H:%M`
  local note="{\"time\": \"$now\", \"type\": \"$1\", \"text\": \"$2\"}"
  layer append -t default -k notifications -v "$note"
}

flash() {
  layer write -t flash -k text -v "$@"
  sleep 5
  layer render
}
