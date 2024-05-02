# ZSH configuration file.
#
# Requires the powerline-go shell theme (use powerlevel9k as fallback)
# For installation instructions, see https://github.com/justjanne/powerline-go
#
# Basically:
#   <install golang>
#   go install github.com/justjanne/powerline-go@latest
#
# Powerlevel9k is used as a fallback if powerline-go is not found.
#
# The theme also requires antigen, which is embedded as a Git submodule
# in this repository. Clone it via:
#
#   git submodule update --init --recursive


# Define internal paths
if [ -z "$GOPATH" ]; then
    export GOPATH="${HOME}/go"
fi

ANTIGEN_PATH="${HOME}/dotfiles/antigen"
POWERLINE_PATH="${GOPATH}/bin/powerline-go"

# Set up powerline-go
powerline_precmd() {
    eval "$(${POWERLINE_PATH} -error $? -shell zsh -eval \
        -modules 'nix-shell,ssh,venv,user,host,cwd,perms' \
        -modules-right 'exit,jobs,git,docker,kube' \
        -priority 'root,venv,ssh,exit,cwd,user,perms,host,jobs,git-branch,git-status,cwd-path' \
        -cwd-max-depth 2 -max-width 30 -truncate-segment-width 25)"
}

install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

SHELL_THEME="powerlevel9k"
if [ -x "$POWERLINE_PATH" ]; then
    SHELL_THEME="powerline"
fi
 
# Powerlevel9k configuration
if [[ "$SHELL_THEME" == "powerlevel9k" ]]; then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir background_jobs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs)
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
fi

# Powerline shell theme
if [[ "$SHELL_THEME" == "powerline" ]]; then
    install_powerline_precmd
fi

# Source custom environment variables (PATH etc.)
if [ -f "${HOME}/.env" ]; then
    source "${HOME}/.env"
fi

# Load Antigen package manager
source "${ANTIGEN_PATH}/antigen.zsh"

# Load oh-my-zsh library.
antigen use oh-my-zsh
# Select theme.
antigen theme robbyrussell
# Load bundles from the default repo (oh-my-zsh).
antigen bundle git
antigen bundle encode64
antigen bundle colored-man-pages
# Load bundles from external repos.
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle joshskidmore/zsh-fzf-history-search
antigen bundle agkozak/zsh-z
antigen bundle djui/alias-tips
antigen bundle MichaelAquilina/zsh-auto-notify

# Apply plugins and themes
antigen apply 2>&1 > /dev/null

# Tree-view for kill command completion
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -e -o pid,user,tty,cmd'

# Setup shell history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|pwd|exit)*"

# https://zsh.sourceforge.io/Doc/Release/Options.html (16.2.4 History)
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.
setopt HIST_FIND_NO_DUPS     # Do not display a previously found event.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.

# tmux
alias tmux="nvm use 18.18.0; TERM=screen-256color-bce tmux"

# My weather station 
weatherInLocation() {
  curl wttr.in/"${1:shannon-ireland}"
}

# Custom aliases
alias weather=weatherInLocation
alias fd=fdfind
alias open=xdg-open
alias python=python3

# UpCo aliases
alias front-upco-code="cd ~/Projects/Work && code ~/Projects/Work/web-apps-upco.code-workspace && exit 0"
alias api-upco-code="cd ~/Projects/Work && code ~/Projects/Work/api-upco.code-workspace  && exit 0"
alias backoffice-upco-code="cd ~/Projects/Work && code ~/Projects/Work/backoffice-upco.code-workspace  && exit 0"
alias serve-api="cd ~/Projects/Work/upco && nx serve api"
alias serve-backoffice="cd ~/Projects/Work/upco && nx serve backoffice-template --port 4300"
alias serve-web-pos="cd ~/Projects/Work/upco && nx serve web-pos --port 4200"
alias serve-web-gift-cards="cd ~/Projects/Work/upco && nx serve web-gift-cards --port 4500"
alias serve-web-ordering="cd ~/Projects/Work/upco && nx serve web-ordering --port 4400"

# list grep
alias l="ls -lahCF"
alias lg="ls -lahCF | grep"
# List open Ports
alias lsp="sudo lsof -i -n -P | grep LISTEN"
# pbcopy alias https://garywoodfine.com/use-pbcopy-on-ubuntu/
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# bc: decimal separator comma vs. point
# https://askubuntu.com/questions/930210/bc-decimal-separator-comma-vs-point
alias bcl='xmodmap -e "keycode 91 mod2 = KP_Delete period"; bc -l; xmodmap -e "keycode 91 mod2 = KP_Delete comma"'

# Switch to master, pull latest master from origin, switch back to previous branch, MERGE MASTER into.
# TODO: Implementing `merge_master` as a function not a alias could be cleaner.
alias merge_dev='CB=`git branch --show-current` && git checkout develop && git pull && git checkout $CB && git merge develop'

# nodejs repl
# alias repl="NODE_PATH=$(npm root -g) node ~/dotfiles/repl.js"

# neoVim without using ~/.vimrc file
#alias nvim="nvim -u NONE"
alias nv="nvm use 18.18.0; nvim"

export PATH="$PATH:/home/borys/.dotnet/:/usr/lib/postgresql/12/bin:/usr/local/bin/path:/usr/local/go/bin:/home/borys/go/bin"
fpath=(~/.zsh.d/ $fpath)
source $HOME/.zsh.d/z.sh

# bun completions
[ -s "/home/borys/.bun/_bun" ] && source "/home/borys/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rust modules
export PATH="/home/borys/rust_modules/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NODE_OPTIONS="--max-old-space-size=8192"
