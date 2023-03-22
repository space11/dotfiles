# Use antigen
source $HOME/.antigen.zsh

# Use Oh-My-Zsh
antigen use oh-my-zsh

# Set theme
antigen theme robbyrussell

# Set plugins (plugins not part of Oh-My-Zsh can be installed using githubusername/repo)
antigen bundle git
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle agkozak/zsh-z
antigen bundle joshskidmore/zsh-fzf-history-search


if [[ "$OSTYPE" == "darwin"* ]]; then
    antigen bundle osx
fi

# Apply changes
antigen apply

# Custom aliases
alias fd=fdfind
alias open=xdg-open
alias python=python3
alias weather="curl wttr.in/shannon-ireland"

# UpCo aliase
alias front-upco-code="cd ~/Projects/Work && code ~/Projects/Work/front-upco.code-workspace && exit 0"
alias api-upco-code="cd ~/Projects/Work && code ~/Projects/Work/api-upco.code-workspace  && exit 0"
alias backoffice-upco-code="cd ~/Projects/Work && code ~/Projects/Work/backoffice-upco.code-workspace  && exit 0"
alias serve-api="cd ~/Projects/Work/upco && nx serve api"
alias serve-backoffice="cd ~/Projects/Work/upco && nx serve backoffice-template --port 4300"
alias serve-web-pos="cd ~/Projects/Work/upco && nx serve web-pos --port 4200"
alias serve-web-gift-cards="cd ~/Projects/Work/upco && nx serve web-gift-cards --port 4500"
alias serve-web-ordering="cd ~/Projects/Work/upco && nx serve web-ordering --port 4400"


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
alias merge_master='CB=`git branch --show-current` && git checkout master && git pull && git checkout $CB && git merge master'

# nodejs repl
alias repl="NODE_PATH=$(npm root -g) node ~/dotfiles/repl.js"

# neoVim without using ~/.vimrc file
alias nvim="nvim -u NONE"

export PATH="$PATH:/home/borys/.dotnet/:/usr/lib/postgresql/12/bin:/usr/local/bin/path:/usr/local/go/bin"
fpath=(~/.zsh.d/ $fpath)
fpath=(~/.zsh.d/ $fpath)
