
# git {{{

# don't use the gc (git commit -v) in git plugin
#unalias gc

# fbrr - checkout git branch (including remote branches)
#fbrr() {
#    local branches branch
#    branches=$(git branch --all | grep -v HEAD) &&
#    branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
#    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
#}

# fbr - checkout git branch (including remote branches)
# fbr() {
  # local branches branch
  # branches=$(git branch --all | grep -v HEAD) &&
  # branch=$(echo "$branches" |
           # fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  # git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
# }

# fco - checkout git branch/tag
fco() {
    local tags branches target
    tags=$(
        git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
    branches=$(
        git branch --all | grep -v HEAD |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -d 50% -- --no-hscroll --ansi +m -d "\t" -n 2) || return
    git checkout $(echo "$target" | awk '{print $2}')
    # -d 50% is for tmux split-pane or in a tmux popup window IF you're on a tmux session.
    # --ansi tells fzf to extract and parse ANSI color code in the input
}

# fcoc - checkout git commit
fcoc() {
    local commits commit
    commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
    local out sha q
    while out=$(
        git log --decorate=short --graph --oneline --color=always |
        fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
        q=$(head -1 <<< "$out")
        while read sha; do
            [ -n "$sha" ] && git show --color=always $sha | less -R
        done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    done
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
    color_highlight='\x1b[33;1m'
    color_default='\x1b[1;37m'
    local commits commit sha
    commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
    sha=$(echo "$commit" | awk '{print $1}')
    echo "$sha" | pbcopy
    echo "${color_highlight}$sha ${color_default}copied."
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
# fzf show stash content
fstash() {
  local out q k sha

  while out=$(
      git stash list --pretty="%C(yellow)%gd %C(blue)%h %>(14)%Cgreen%cr %C(white)%gs" |
      fzf --ansi --no-sort --query="$q" --print-query \
          --expect=ctrl-d,ctrl-a
  );

  do
      IFS=$'\n'; set -f
      lines=($(<<< "$out"))
      unset IFS; set +f
      q="${lines[0]}"
      k="${lines[1]}"
      stash="${lines[-1]}"
      # stash = 'stash@{1} fc83d5f    3 hours ago On 2juvh5p_redemption_code_dapp2: local-config'
      selector="${stash%% *}" # 刪除從左數來第一個空白及右邊全部，得到 stash@{1}
      sha="${stash#* }" # 刪除從左邊開始至空白，得到 'fc83d5f    3 hours ago On 2juvh5p_redemption_code_dapp2: local-config'
      sha="${sha%% *}"  # 刪除從左數來第一個空白及右邊全部

      [[ -z "$sha" || -z "$selector" ]] && continue

      if [[ "$k" == 'ctrl-d' ]]; then
          if ask "Do you want to pop stash: ${stash}?\n${color_warning}Confirm" ; then
              git stash pop $selector;
              echo "$stash deleted."
              break;
          fi
          break;
      elif [[ "$k" == 'ctrl-a' ]]; then
          git stash apply $selector;
          break;
      else
          git -c color.ui=always stash show -p $sha | less -+F
      fi
  done
}

function gfix() {
    vi -p `git diff --name-only | sort | uniq`
}

function git-fixup () {
  git ll -n 20 | fzf | cut -f 1 | xargs git commit --no-verify --fixup
}

fadd() {
    local out q n addfiles
    while out=$(
        git status --short |
        awk '{if (substr($0,2,1) !~ / /) print $2}' |
        fzf --multi --color=dark --cycle --border --ansi --exit-0 --expect=ctrl-d --preview-window=up:70% --preview='git diff --color {+1}'); do
        q=$(head -1 <<< "$out")
        n=$[$(wc -l <<< "$out") - 1]
        addfiles=(`echo $(tail "-$n" <<< "$out")`)
        [[ -z "$addfiles" ]] && continue
        if [ "$q" = ctrl-d ]; then
            git diff --color=always $addfiles | less -R
        else
            git add $addfiles
        fi
    done
}

# To search branch or tag by using fzf and return a result
fzf-git-ref() {
    color_default='\x1b[1;37m';
    color_warning='\x1b[1;31m';
    color_tag='\x1b[33;1m';
    color_branch='\x1b[34;1m';
    color_command='\x1b[1;37m';

    local tags branches target type name final;
    branches=$(
        git branch --all | grep -v HEAD             |
        sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
        sort -u          | awk '{print "\x1b[34;1mBranch\x1b[m\t" $1}') || return;
    tags=$(
        git tag | awk '{print "\x1b[33;1mTag\x1b[m\t" $1}') || return;

    target=$(
        (echo "$tags"; echo "$branches") |
        fzf-tmux -d 50% -- --no-hscroll --ansi +m -d "\t" -n 2
        ) || return;

    type=$(echo "$target" | awk '{ print $1 }')
    name=$(echo "$target" | awk '{ print $2 }')
    final="$type|$name"
    echo "$final" # echo is used for returning value
    return 0      # return 0 means function executed successfully
}

# fdd = git delete force
fdd() {
    color_default='\x1b[1;37m'
    color_warning='\x1b[1;31m'
    color_tag='\x1b[33;1m'
    color_branch='\x1b[34;1m'
    color_command='\x1b[1;37m'

    target=`fzf-git-ref` # catch output from echo $final
    return_code="$?"

    if [ "$return_code" -ne 0 ]; then
        echo "aborted! ($return_code)"
        return "$return_code"
    fi

    target=$(print -r -- ${target//|/ }) # replace | with space

    type=$(echo "$target" | awk '{print $1}')
    name=$(echo "$target" | awk '{print $2}') || 

    if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
        selected_color='\x1b[34;1m'
    fi
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
        selected_color='\x1b[33;1m'
    fi

    if ask "${color_default}Do you want to delete local ${selected_color}${type} ${color_default}'${name}'?\n${color_warning}Confirm" ; then
        echo "${color_default}"
        if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
            git branch -d -f $name
        fi
        if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
            git tag -d $name
        fi
        ## status_code 0 is success
        #if [ $status_code -eq 0 ]; then
        #    echo "${color_default}Remote ${selected_color}${type} ${color_default}'${name}'${color_warning} is deleted."
        #else
        #    echo "${color_default}fail to delete ${selected_color}${type} ${color_default}'${name}'${color_warning}, reason: $result"
        #fi
    fi
}

# fddp = git delete remote ref
fddp() {
    color_default='\x1b[1;37m'
    color_warning='\x1b[1;31m'
    color_tag='\x1b[33;1m'
    color_branch='\x1b[34;1m'
    color_command='\x1b[1;37m'

    target=`fzf-git-ref` # catch output from echo $final
    return_code="$?"

    if [ "$return_code" -ne 0 ]; then
        echo "aborted! ($return_code)"
        return "$return_code"
    fi

    target=$(print -r -- ${target//|/ }) # replace | with space
    type=$(echo "$target" | awk '{print $1}')
    name=$(echo "$target" | awk '{print $2}')

    selected_color='\x1b[34;1m'
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'branch' ]; then
        selected_color='\x1b[34;1m'
    fi
    if [ $(echo "$type" | awk '{print tolower($0)}') = 'tag' ]; then
        selected_color='\x1b[33;1m'
    fi

    if ask "${color_default}Do you want to delete remote ${selected_color}${type} ${color_default}'${name}'?\n${color_warning}Confirm" ; then
        echo "${color_default}"
        git push origin -d $name
        #result=$? # store command $(git push origin -d $target) as variable 'reulst'
    fi
}

# }}}

