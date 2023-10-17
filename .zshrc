# If you come from bash you might have to change your $PATH.


# Path to your oh-my-zsh installation.
export ZSH="/home/d074052/.oh-my-zsh"
export JAVA_HOME="/usr/lib/jvm/default/"
export JDK_HOME="/usr/lib/jvm/default-runtime"
export MOZ_ENABLE_WAYLAND=1
export GTK_THEME=Adwaita:dark
export TERM=xterm-256color

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="lambda"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git, zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $HOME/repos/z/z.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Vi Mode
bindkey -v
export KEYTIMEOUT=1


# Own Env
alias dim='date --iso-8601=minutes --date'
alias c='fg'
alias fu='pkill -9'
alias prg='ps aux | rg'
alias f='"$(fzf)"'
alias tm='tmux'
alias ct='exa --tree'
alias ls='exa --git'
alias ll='ls -l'
alias l='ll -a'
alias vim='nvim'
alias d='dirs -v'
alias gss='git show --name-only'
alias ga='git add'
alias gap='git add -p'
alias gs='git status'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gr='git rebase'
alias gl='git log'
alias gd='git diff'
alias gst='git stash'

alias aud='pulsemixer'
alias blue='bluetoothctl'

export PATH=$HOME/.bin:$HOME/.cargo/bin:$HOME/.local/bin/:$HOME/.pyenv/bin/::$HOME/.pyenv/shims/:$PATH

export GOPATH=$HOME/repos/gopath
export EDITOR=nvim


# fzf
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}


# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key

  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)

  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
#
# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function

vf() {
  local files
  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})
  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi

}

# fuzzy grep open via ag
vg() {
  local file
  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"
  if [[ -n $file ]]
  then
     vim $file
  fi
}

# fuzzy grep open via ag with line number

vg() {
  local file
  local line
  read -r file line <<<"$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

h() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}

doi2bib() {
    stat bib.bib
    echo >> bib.bib
    echo "http://api.crossref.org/works/$1/transform/application/x-bibtex";
    curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtex" >> bib.bib;
    echo > bib.bib
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

di() {
	~/.bin/di "$@" | less
}

loadnvm() {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
