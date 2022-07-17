# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# history config
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=500
HISTFILESIZE=20000

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# the pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.
shopt -s globstar

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

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

if [ "$color_prompt" = yes ]; then
  PS1="[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]] \\$ \[$(tput sgr0)\]"
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

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
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# aliases
. ~/.bash_aliases

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/livia/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/livia/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/livia/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/livia/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

track() {
  git branch --track $1 origin/master
  echo "Checking out $1"
  git checkout $1
}

delete_branch() {
  git branch -D $1
  echo "Deleted local branch $1"
  git push origin --delete $1
  echo "Deleted remote branch origin:$1"
}

git_sync() {
  branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}
  echo "Checking out origin/master"
  git checkout master
  echo "Pulling upstream/master"
  #git pull --rebase upstream
  git pull upstream
  #git rebase -i
  echo "Pushing origin/master"
  git push origin master -f
  echo "Checking out $branch_name"
  git checkout $branch_name
  echo "Pulling $branch_name from origin master"
  #git pull --rebase origin master
  git pull origin master
  branch_name=""
}

git_push() {
  branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}
  #echo "Rebasing $branch_name"
  #git rebase -i
  echo "Pushing origin/$branch_name"
  git push origin $branch_name -f
  branch_name=""
}


alias track=track
alias delete_branch=delete_branch
alias git_sync=git_sync
alias git_push=git_push

export PATH=$PATH:/home/livia/.local/bin
export PATH=$PATH:/home/livia/.local/share/gem/ruby/3.0.0/bin

export TERM=xterm

export ALPHAVANTAGE_API_KEY=KRJN2M88T0U4A6AD

PATH="/home/livia/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/livia/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/livia/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/livia/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/livia/perl5"; export PERL_MM_OPT;

# remove green highlight from dirs in ls
LS_COLORS+=:ow=
