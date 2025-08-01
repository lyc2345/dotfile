
# zel debugging tools {{{
# in vi insert mode, type option-o (^[o) to show the zle line editor buffers
function _showbuffers() {
  local nl=$'\n' kr
  typeset -T kr KR $'\n'
  KR=($killring)
  typeset +g -a buffers
  buffers+="     Pre: ${PREBUFFER:-$nl}"
  buffers+="  Buffer: $BUFFER$nl"
  buffers+="     Cut: $CUTBUFFER$nl"
  buffers+="       L: $LBUFFER$nl"
  buffers+="       R: $RBUFFER$nl"
  buffers+="Killring: $nl$nl$kr"
  zle -M "$buffers"
}
zle -N showbuffers _showbuffers
bindkey "^[o" showbuffers

