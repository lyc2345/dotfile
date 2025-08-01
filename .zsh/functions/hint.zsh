

# print which shell you currently use
show_yourself() {
  echo "CURRENT SHELL: $SHELL" #\u2620
  echo "WHO AM I     : \ufb8a `whoami`"
}
alias currentshell=show_yourself

function list_zsh_plugins() {
    PLUGIN_PATH="$HOME/.oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}
alias zshplugins=list_zsh_plugins


