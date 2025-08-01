
# URL encode something and print it.
function url-encode() {
  setopt extendedglob
  echo "${${(j: :)@}//(#b)(?)/%$[[##16]##${match[1]}]}"
}
# Search google for the given keywords.
function google {
  open "https://www.google.com/search?q=`url-encode "${(j: :)@}"`"
}
alias ggl=google

# toggle iTerm Dock icon
# add this to your .bash_profile or .zshrc
function _toggle_iTerm() {
    pb='/usr/libexec/PlistBuddy'
    iTerm='/Applications/iTerm.app/Contents/Info.plist'

    echo "Do you wish to hide iTerm in Dock?"
    select ync in "Hide" "Show" "Cancel"; do
        case $ync in
            'Hide' )
                $pb -c "Add :LSUIElement bool true" $iTerm
                echo "relaunch iTerm to take effectives"
                break
                ;;
            'Show' )
                $pb -c "Delete :LSUIElement" $iTerm
                echo "run killall 'iTerm' to exit, and then relaunch it"
                break
                ;;
        'Cancel' )
            break
            ;;
        esac
    done
}
alias titerm=_toggle_iTerm

# fkill - kill process
function _fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
alias fkill=_fkill

function _list_port() {
    lsof -i -P -n | grep LISTEN
}
alias list_port=_list_port

function _quit() {
    for app in $*; do
        echo "quiting $app..."
        osascript -e 'quit app "'$app'"'
    done
}
alias quit=_quit

function _relaunch() {
    for app in $*; do
        echo "relaunch $app..."
        osascript -e 'quit app "'$app'"'
        open -a $app
    done
}
alias relaunch=_relaunch

function _force_relaunch() {
   app=$1
   echo "Relaunch $app..."
   pkill -KILL -f $app
   sleep 3
   open -a $app
}
alias force_relunch=_force_relaunch

