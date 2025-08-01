# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
# A set of vim, zsh, git and tmux configuration files
# Auther: thoughtbot
# https://github.com/thoughtbot/dotfiles
#

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {

  color_title='\x1b[2;31m'
  color_default='\x1b[1;37m'
  color_highlight='\x1b[33;1m'

  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      # load all files in 'pre' path and end of .zsh
      for config in "$_dir"/pre/**/*.zsh(N-.); do
        . $config
        echo "loaded pre/configs: ${color_highlight}$config${color_default}"
      done
    fi

    #if [ -d "$_dir/bundle" ]; then
    #  # load all files in 'post' path and end of .zsh
    #  for config in "$_dir"/bundle/*.zsh(N-.); do
    #    . $config
    #    echo "loaded bundle/config: ${color_highlight}$config${color_default}"
    #  done
    #fi

    for config in "$_dir"/**/*(N-.); do
      # load file exclude pre|post|functions|bundle
      case "$config" in
        "$_dir"/(pre|post|functions|bundle)/*|*.zwc)
          :
          ;;
        *)
          . $config
          echo "loaded /configs: ${color_highlight}$config${color_default}"
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      # load all files in 'post' path and end of .zsh
      for config in "$_dir"/post/**/*.zsh(N-.); do
        . $config
        echo "loaded /post/configs: ${color_highlight}$config${color_default}"
      done
    fi
  fi
}

_load_functions() {
  # load custom executable functions
  for function in ~/.zsh/functions/*; do
    source $function
    #echo "loaded functions: $function"
  done
}

_load_local_setting() {
    color_highlight='\x1b[34;1m'
    # Local config first
    echo "loaded user config: ${color_highlight}$HOME/.zsh/.zshrc.local${color_default}"
    [[ -f ~/.zsh/.zshrc.local ]] && source ~/.zsh/.zshrc.local
}


_load_functions
_load_settings "$HOME/.zsh"
_load_local_setting

# remove duplicate paths in the end of loading zshfiles
clean_duplicate_paths


# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"

export LDFLAGS="-L/opt/homebrew/opt/openssl@1.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.0/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.0/lib/pkgconfig"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
