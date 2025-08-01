
function _find_symlink_path() {
  find $1 -type l -ls
}

alias symlinkpath=_find_symlink_path

# ag:  Recursively search for PATTERN in PATH.  Like grep or ack, but faster.
_ag () { [[ -f /opt/homebrew/bin/ag ]] && /opt/homebrew/bin/ag  -i --pager="less -R -S" $@ }
alias ag=_ag

# easy file name finding
# see http://stackoverflow.com/questions/762348/how-can-i-exclude-all-permission-denied-messages-from-find
_af () { find . -iname "*$@*" 2>&1 | grep -v 'Permission denied'}
alias ag=_af

# get the absolute path
_abf () { find `pwd` -iname "*$@*"}
alias abf=_abf

# use ag | fzf instead?
#alias gline="grep --line-buffered --color=never -r "" * | fzf"
ctrlp_line() {
  local selected
  if selected=$(ag --nobreak --nonumbers --noheading . | fzf -q "$LBUFFER"); then
    LBUFFER=$selected
  fi
  zle redisplay
}
#zle -N ctrlp_line
#bindkey "\ef" ctrlp_line

# To echo $PATH
function path() {
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}

# To echo $PATH prettier
function prettypath() {
    echo "$PATH" | tr ":" "\n" | nl
}

# use for export a path, export if not exist
pathmunge () {
  if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
     if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
     else
      PATH=$1:$PATH
     fi
  fi
}

# clean up duplicate path
clean_duplicate_paths() {
  PATH=$(echo $PATH | tr ':' '\n' | perl -lne 'chomp; print unless $k{$_}; $k{$_}++' | tr '\n' ':' | sed 's/:$//')
}

# Functions to help us manage paths.  Second argument is the name of the
# path variable to be modified (default: PATH)
pathremove () {
  local IFS=':'
  local NEWPATH
  local DIR
  local PATHVARIABLE=${2:-PATH}
  for DIR in ${!PATHVARIABLE} ; do
    if [ "$DIR" != "$1" ] ; then
      NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
    fi
  done
  export $PATHVARIABLE="$NEWPATH"
}

function file_count() {
  filePath=$1
  echo "files: $(eval "ls $1 | wc -l")"
}
alias fcount=file_count

# easy dmg generation
# dmg /My/Source/Folder NameOfDmg
dmg(){
  hdiutil create -fs HFS+ -srcfolder "$1" -volname "$2" "$2.dmg"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  out=$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fcd - cd to selected directory
fcd() {
  local dir
  dir=$(find ${1:-*} -path '*/\.*' -prune \
      -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# open folder {{{
# open the file's directory
function openfinder() {
  if [[ -d $1 ]] && ! [[ -z ${1##*.} ]]; then
    # if the folder has file extension, open it with the default handler
    open $1
    return
  fi
  open .
}
alias of=openfinder

# open the current folder in Finder's tab
function oft() {
  if [[ -d $1 ]] && ! [[ -z ${1##*.} ]]; then
    # if the folder has file extension, open it with the default handler
    open $1
    return
  fi
  local folder_name=$1
  if ! [[ -d $1 ]]; then
    # it is a file, get the enclosing folder
    folder_name="$(dirname "$1")"
  fi

  # if no arguments are given, we use the current folder
  # 'pwd -P' will resolve the symbolic link (Finder always resolves the symbolic link)
  oft_absolute_path=$(cd ${folder_name:-.}; pwd -P )
  # execute the applescirpt
  osascript 2>/dev/null <<EOF
    on currentFinderPath()
        tell application "Finder"
            try
                set finder_path to POSIX path of (target of window 1 as alias)
            on error
                set finder_path to ""
            end try
        end tell
    end currentFinderPath

    # Finder returns a path with trailing slash
    # But PWD doesn't have one, so we add one for it
    set new_tab_path to "$oft_absolute_path" & "/"

    tell application "Finder"
        activate

        if not (exists window 1) then
            make new Finder window
        end if

        set finder_path to my currentFinderPath()

        if finder_path = "" then
            # the finder's window doesn't contain any folders
            set target of front window to (new_tab_path as POSIX file)
            return
        end if
    end tell

    if new_tab_path = finder_path then
        # the finder's tab is already there
        return
    end if

    # get the last path component name e.g., /usr/local/ -> local
    # we need it to compare with the name of radio buttons (the name of tabs)
    set ASTID to AppleScript's text item delimiters
    set AppleScript's text item delimiters to {"/"}
    # assume there is a trailing slash at the end of path
    set last_folder_name to text item -2 of new_tab_path
    set AppleScript's text item delimiters to ASTID

    # iterate through all radio buttons to check if the tab has been opened or not
    # if it is not working for the future versions of Finder
    # iteration all UI components by 'entire contents of window 1'
    # see [Finding Control and Menu Items for use in AppleScript User Interface Scripting](http://hints.macworld.com/article.php?story=20111208191312748)
    tell application "System Events"
        tell process "Finder"
            set radio_buttons to radio buttons of window 1
            set button_num to length of radio_buttons
            repeat with i from 1 to button_num
                try
                    set button_i to item i in radio_buttons

                    if not title of button_i = last_folder_name then
                        # the tab name doesn't match
                        # simulated 'continue'
                        error 0
                    end if

                    # click the button will change the Finder's target path
                    click button_i
                    set finder_path to my currentFinderPath()

                    if new_tab_path = finder_path then
                        # the finder's tab is already there
                        return
                    end if
                    # if we switch tab, the buttons will become invalid
                    # so we have to retrieve them again
                    set radio_buttons to radio buttons of window 1
                end try
            end repeat
        end tell
    end tell

    # the folder is not opened yet
    # open a new tab in Finder
    tell application "System Events" to keystroke "t" using command down

    # set the Finder's path
    tell application "Finder"
        set target of front window to (new_tab_path as POSIX file)
    end tell

    return
EOF
  # clear the tempory veriable
  unset oft_absolute_path
}
alias oft=oft

fcode() {
  if [ -z "$1"] && $1="./"
  local out file
  out=$(fzf-tmux --query="$1" --height="40%" --exit-0)
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    code "$file"
  fi
}

# }}}
