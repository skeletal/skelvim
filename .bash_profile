alias code="cd ~/Dropbox/Coding"
alias crazy="python3 ~/Dropbox/Coding/crazyflie-clients-python/bin/cfclient"


export CLICOLOR=1;
export TERM="xterm-color"
export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

function __prompt_command() {
    local EXIT="$?"             # This needs to be first

    local RCol='\[\e[0m\]'      # Terminal Default

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'

    PS1=""

    if [ $EXIT != 0 ]; then
        PS1+="${Red}[\!]"      # Add red if exit code non 0
    else
        PS1+="${Gre}[\!]"      # Green on success
    fi

    PS1+="${Gre}[\u@\h]"       # username@hostname
    PS1+="${BBlu}[$PWD]"       # full path
    PS1+="${RCol}\n[\t] $> "    # time and prompt on newline
}


export VISUAL='vim'
alias cp='cp -i'
alias ls='ls -G'
alias mv='mv -i'
set -o vi
export GREP_COLOR="1;33"
alias grep="grep --color=auto"
export MOZ_DISABLE_PANGO=1
export FIREFOX_DSP=none

# less man page colors
export GROFF_NO_SGR=1
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'                                 
export LESS_TERMCAP_se=$'\E[0m'                           
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'
 extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar xvJf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *.xz)        unxz $1        ;;
      *.exe)       cabextract $1  ;;
      *)           echo "\`$1': unrecognized file compression" ;;
    esac
  else
    echo "\`$1' is not a valid file"
  fi
}


#Better colours for gruvbox colorscheme
if [ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh" ]
then
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"
fi
