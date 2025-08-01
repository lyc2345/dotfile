
# vscode {{{
# Open vscode project
function open_vscode_project_current_file_path() {
  echo "Opening with vscode..."
  if [ -e *.vscode ]; then
    open *.vscode
  else
    code .
  fi
}
alias vc=open_vscode_project_current_file_path

function toggleVSCodeKeyNotHold() {
  option = $1
  boolValue = false
  if $1 == '1' || $1 == 'on' || $1 == 'ON' ; then
    ioolValue = false
  else
    boolValue = true
  fi
  echo "Turn off VSCode key hold: $boolValue"
  eval "defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool $boolValue"
}

# }}}


# xcode {{{

# Remove Xcode DerivedData
function xcode_cleanup_cache() {
    echo "cleaning up Xcode cached..."
    local files
    xcode_deriveddata_path=$HOME/Library/Developer/Xcode/DerivedData
    find $xcode_deriveddata_path -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} +
    rm -rf $HOME/Library/Caches/com.apple.dt.Xcode/*
    rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
    rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang.${USER}/ModuleCache"
}
alias xcl=xcode_cleanup_cache

# Remove Xcode archive files
function xcode_cleanup_archive() {
    local files
    xcode_archives_path=$HOME/Library/Developer/Xcode/Archives
    if ask "Do you want to clean up Xcode archives?" ; then
        find $xcode_archives_path -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} +
        echo "Xcode archives cleaned."
    fi
}
alias xclarchives=xcode_cleanup_archive

# Open Xcode project
function open_xcode_project_current_file_path() {
  echo "Opening with Xcode..."
  if [ -e *.xcworkspace ]; then
    open *.xcworkspace
  else
    open *.xcodeproj
  fi
}
alias xc=open_xcode_project_current_file_path

# }}}

# alfred workflow {{{
# get the current file path from Xcode
function xcodeCurrentFilePath() {
    # execute the applescirpt
    local tuple=`osascript 2>/dev/null ~/Dropbox/MacSetting/osxc/AlfredScript/xcodeFilePath.scpt`

    # check if the osascript is executed successfully
    if [ $? -eq 0 ]
    then
        echo $tuple
    else
        echo ""
    fi
}


function activateNVimWithXcodeCurrentFile() {
    local shouldGet=$(activateNVim)
    local filePath=""
    local tuple=""
    local line=0
    if (( $shouldGet > 0 )); then
        tuple=$(xcodeCurrentFilePath)
        if ! [[ -z $tuple ]]; then
            line=`echo $tuple | cut -d "&" -f 1`
            filePath=`echo $tuple | cut -d "&" -f 2`
            if (( $line > 0 )); then
                eval "/usr/local/bin/nyaovim "$filePath
                goToNVimLine $line
            fi
        fi
    fi
}

# }}}

