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
alias start-dev="terminator -l dev -p default"
alias fd=fdfind
alias open=xdg-open
alias front-upco-code="code ~/Projects/Work/front-upco.code-workspace && exit 0"
alias api-upco-code="code ~/Projects/Work/upco.code-workspace  && exit 0"
alias python=python3

# bc: decimal separator comma vs. point
# https://askubuntu.com/questions/930210/bc-decimal-separator-comma-vs-point
alias bcl='xmodmap -e "keycode 91 mod2 = KP_Delete period"; bc -l; xmodmap -e "keycode 91 mod2 = KP_Delete comma"'


export PATH="$PATH:/home/borys/.dotnet/:/usr/lib/postgresql/12/bin"
