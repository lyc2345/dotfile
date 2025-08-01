
# Export path

# Homebrew for x86 (intel)
export PATH="/opt/homebrew/opt/avr-gcc@14/bin:$PATH"
export PATH="/usr/local/Homebrew/bin:$PATH"

# Homebrew for arm64 (m1 chip)
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# export these 2 paths will use some basic command from BSD(OSX) to GNU(Linux)
# e.g. ls mv dir ...etcs
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
#test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

#export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
#export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:/usr/local/bin:$MANPATH"

# Dev Paths
export PATH="$HOME/.jenv/bin:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"

# Fzf
export FZF_BASE="$HOME/.dotfile/.config/.fzf/install"

