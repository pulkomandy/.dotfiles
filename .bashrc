# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Runs just before showing the prompt
function exitstatus {
  # Get status of latest command, and adjust prompt color to indicate success/failure
  if [ "$?" -eq "0" ]
  then
    color=32 # green
  else
    color=31 # red
  fi

  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;'$color'm\]\w\[\033[0m\]\$\[\033[33m\] '
  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
    xterm*|rxvt*)
	  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\w\a\]$PS1"
      ;;
    *)
      ;;
  esac

  preexec_interactive=1
}

# The prompt leaves the command line in blue, but we hook at preexec to reset it to the default color.
preexec () {
    #[ -n "$COMP_LINE" ] && return  # do nothing if completing
    #[ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
    [ "$preexec_interactive" = "1" ] || return
    echo -ne '\e[0m'
    preexec_interactive=0
}
trap 'preexec' DEBUG


PROMPT_COMMAND=exitstatus

export EDITOR=vim

shopt -s globstar
shopt -s autocd
shopt -s cdspell
shopt -s dirspell
shopt -s nocaseglob
