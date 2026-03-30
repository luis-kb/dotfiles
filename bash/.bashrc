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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "/home/luis/.deno/env"
source /home/luis/.local/share/bash-completion/completions/deno.bash

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/luis/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(direnv hook bash)"


# GO
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:"$(go env GOPATH)/bin"


# LLMs
export ANTHROPIC_API_KEY=$(secret-tool lookup llm anthropic)


# Gcloud stuff (because they can't create a good cli for sh*t
alias gslist='gcloud secrets list'
gsget() {
  local secret="$1"
  local project_flag=""
  [[ -n "$2" ]] && project_flag="--project=$2"
  gcloud secrets versions access latest --secret="$secret" $project_flag
}

# Python alias
alias python='python3.14'


# Duck duck search
duck() {
    local query=$(jq -rn --arg s "$1" '$s | @uri')
    w3m "https://duckduckgo.com/?q=$query"
}

# TODO Change me base on system (how we do this effectively?)
export NOTES_PATH=$HOME/code/notes

# Open today's note
today() {
    cd $NOTES_PATH && nvim $(date +%d-%m-%y).md && cd -
}


# =====================================
# ========= Bluma file ================
# =====================================
#
# Investigate the zeigarnik effect further
bluma() {
    nvim ~/.bluma
}

bloop() {
    echo "@loop: $1" >> ~/.bluma
}

binterrupt() {
    echo "---INTERRUPTED $(date +%H:%M)---" >> ~/.bluma
    nvim +'normal Go' ~/.bluma
}


# =====================================
# ========= Task tracking =============
# =====================================

b_t() {
    # Start a task: t "fix the login bug"
    echo "$1" > ~/.tmux_task
    [[ -n "$TMUX" ]] && tmux refresh-client -S
    echo "Task started: $1"
}

b_td() {
    # Open long-form task detail in nvim (freeform scratch file)
    nvim ~/.tmux_task_detail
    # Note: detail file is NOT cleared on ti/tre — persists as notes
}

b_ti() {
    # Interrupt current task (saves to bluma + last)
    local task=$(cat ~/.tmux_task 2>/dev/null)
    [[ -z "$task" ]] && echo "No active task" && return
    echo "$task" > ~/.tmux_task_last
    echo "---INTERRUPTED $(date +%H:%M): $task---" >> ~/.bluma
    echo "" > ~/.tmux_task
    [[ -n "$TMUX" ]] && tmux refresh-client -S
    echo "Interrupted: $task"
}

b_tre() {
    # Resume last interrupted task
    local last=$(cat ~/.tmux_task_last 2>/dev/null)
    [[ -z "$last" ]] && echo "No interrupted task" && return
    echo "$last" > ~/.tmux_task
    echo "---RESUMED $(date +%H:%M): $last---" >> ~/.bluma
    [[ -n "$TMUX" ]] && tmux refresh-client -S
    echo "Resumed: $last"
}

b_tc() {
    # Clear task (done)
    local task=$(cat ~/.tmux_task 2>/dev/null)
    echo "" > ~/.tmux_task
    [[ -n "$TMUX" ]] && tmux refresh-client -S
    [[ -n "$task" ]] && echo "Done: $task"
}


# ===========================
# ==== Docker commands ======
# ===========================

removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armageddon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

# ==================
# === Useful git ===
# ==================

# Stash changes, pull rebase and pop changes (git state-saving pull)
gsspull() {
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo 'something to stash'
        git stash --quiet
        STASH=true
    else
        echo 'nothing to stash'
        STASH=false
    fi

    git pull --rebase

    if $STASH; then
        echo 'popping the stash'
        git stash pop --quiet
    fi
}
. "$HOME/.cargo/env"
