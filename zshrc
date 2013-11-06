# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kardan"

CORRECT_IGNORE=".*"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git nyan)

# Aliases
alias l='ls -alp'
# -r is recusive, -I ignores binaries, and we don't want to look in .svn
# probably going to just use "ack" from now on.
alias rg='grep -rI --exclude-dir="\.svn"'
alias updot='~/code/python/updot/updot.py'
alias sshmtu='ssh magrimes@wopr.csl.mtu.edu'
alias dv='dirs -v'
alias ftb='/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bin/java -jar ~/Downloads/FTB_Launcher.jar'

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

setopt histverify
setopt listpacked

unsetopt nomatch
unsetopt correct_all
unsetopt beep

export SVN_EDITOR=vim
PATH=/Users/mgrimes/pear/bin:$PATH
fpath=(/Users/mgrimes/.zsh-completions/src $fpath)

export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:"/Applications/Postgres.app/Contents/MacOS/bin"

eval "$(rbenv init -)"
