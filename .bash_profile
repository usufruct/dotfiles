#aliases
alias be="bundle exec "

export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"

function profile {
  subl ~/.bash_profile
}

# show git branch in terminal ( from: http://www.developerzen.com/2011/01/10/show-the-current-git-branch-in-your-command-prompt/ )
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOUR="\[\033[0m\]"

export PS1="\n\w $YELLOW\$(parse_git_branch)$NO_COLOUR\n\h: $GREEN\u$NO_COLOUR\$ "
alias be="bundle exec"

export ARCHFLAGS="-arch x86_64"

export EDITOR=vim

export PATH="/usr/local/sbin:$PATH"