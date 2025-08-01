
# >>> https://github.com/bhilburn/powerlevel9k <<<
# => powerlevel9k

# >>> https://github.com/romkatv/powerlevel10k <<<
# => powerlevel10k

prompt_spotify_status() {
osascript <<EOD
  tell application "Spotify"
    if it is running then
      do shell script "sh ~/.dotfile/.now_playing"      
    end if
  end tell
EOD
}

# Powerlevel9k settings
apply_custom_powerlevel10k_theme() {
  # 若當前登入的帳號為你的帳號 xxx，就不用特別顯示出來
  DEFAULT_USER=`whoami`

  # 使用 nerd font 時可以顯示更多 icon。詳情請參考 powerlevel9k wiki
  POWERLEVEL9K_MODE='nerdfont-complete'

  # Custom segment "now playing"
  POWERLEVEL9K_CUSTOM_NOW_PLAYING='~/.dotfile/.now_playing'

  # Seperators
  POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\ue0b0'
  POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\ue0b1'
  POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\ue0b2'
  POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\ue0b7'
  
  # OS segment
  POWERLEVEL9K_OS_ICON_BACKGROUND='black'
  POWERLEVEL9K_LINUX_ICON='%F{cyan} \uf303 %F{white} arch %F{cyan}linux%f'

  # VCS icons
  POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d2 '
  POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113 '
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
  POWERLEVEL9K_VCS_BRANCH_ICON=$''
  POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
  POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421'
  POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
  POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
  POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '

  # PYENV 
  POWERLEVEL9K_PYENV_FOREGROUND="236"
  POWERLEVEL9K_PYENV_BACKGROUND="green"
  POWERLEVEL9K_PYTHON_ICON='\UE73C' #\U1F40D

  # RBENV
  POWERLEVEL9K_RBENV_FOREGROUND="236"
  POWERLEVEL9K_RBENV_BACKGROUND="red"

  # Status
  #POWERLEVEL9K_OK_ICON=$'\uf164'
  #POWERLEVEL9K_FAIL_ICON=$'\uf165'
  #POWERLEVEL9K_CARRIAGE_RETURN_ICON=$'\uf165'
  #POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
  #POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
  #POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
  #POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
  #POWERLEVEL9K_STATUS_VERBOSE=false
  #POWERLEVEL9K_STATUS_CROSS=false
  
  # Dir
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=10
  POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right" # truncate_middle
  
  user_with_skull() {
    echo -n "\ufb8a $(whoami)"
  }
  POWERLEVEL9K_CUSTOM_USER="user_with_skull"

  # Promp settings
  POWERLEVEL9K_PROMPT_ON_NEWLINE=true   # Left Prompt on new line
  POWERLEVEL9K_RPROMPT_ON_NEWLINE=false # Right Prompt on new line
  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%K{white}%k"
  #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{black} `user_with_skull` %K{white}%F{white}\ue0b0%K{white}%F{black} \UF017 `date +%T` %f%F{white}%k\ue0b0%f " # \uf155 : $
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{white}%F{236} `user_with_skull` %K{white}%F{236} \UF017 `date +%T` %f%F{white}%k\ue0b0%f " # \uf155 : $
  # 左側
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh context dir dir_writable vcs rbenv pyenv background_jobs vi_mode status root_indicator) # custom_user # newline # status
  # 右側
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(battery ram disk_usage) # status background_jobs history time # custom_now_playing # load # ip

  # Disable Right Prompt
  POWERLEVEL9K_DISABLE_RPROMPT=true

  # Adding Newline before Each prompt
  POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  
  # Command auto-correction
  ENABLE_CORRECTION="true"
}
apply_custom_powerlevel10k_theme
#
# powerlevel9k
#ZSH_THEME="powerlevel9k/powerlevel9k" # use github copy into .oh-my-zsh/theme/powerlevel9k
#source /usr/local/opt/powerlevel9k/powerlevel9k.zsh-theme # use Brew 🍺
#
# powerlevel10k
#ZSH_THEME="powerlevel10k/powerlevel10k" # use github copy into .oh-my-zsh/theme/powerlevel9k
source $HOME/.dotfile/powerlevel10k/powerlevel10k.zsh-theme # use clone
#source ~/.oh-my-zsh/themes/powerlevel10k/powerlevel10k.zsh-theme # use Brew 🍺


