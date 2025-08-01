
current_time() {
  python -c 'import time; print(int(time.time() * 1000))'
}

timeit() {
  local start=$(current_time)
  $@
  local exit_code=$?
  local end=$(current_time)
  echo >&2 "took ~$((${end}-${start})) milliseconds. exited with ${exit_code}"
  return $exit_code
}

