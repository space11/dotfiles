# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# OMZ plugins
plugins=(git zsh-fzf-history-search z zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# History deduplication (override OMZ's HIST_IGNORE_DUPS which only catches consecutive dupes)
setopt HIST_IGNORE_ALL_DUPS    # drop older occurrences when adding a new identical entry
setopt HIST_SAVE_NO_DUPS       # never save dupes to the history file
setopt HIST_FIND_NO_DUPS       # don't show dupes when searching (affects C-r fzf)
setopt HIST_REDUCE_BLANKS      # collapse multiple spaces in stored commands

# Custom function autoload directory (~/.zfunc/<name> -> autoloaded as <name>)
fpath=("$HOME/.zfunc" $fpath)
autoload -Uz tat

# NVM lazy load (saves several hundred ms on shell startup)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}
for cmd in node npm npx; do
    eval "$cmd() { unset -f $cmd; nvm >/dev/null; command $cmd \"\$@\"; }"
done

# Weather forecast via wttr.in (defaults to Shannon, Co. Clare, Ireland)
# `weather`            -> current conditions for Shannon (one line)
# `weather london`     -> current conditions for a named city
# `weather -f`         -> 3-day forecast for Shannon (-3 / --forecast also work)
# `weather -f london`  -> 3-day forecast for a named city
weather() {
    local default="Shannon,Clare,Ireland"
    local forecast=0
    if [ "$1" = "-f" ] || [ "$1" = "--forecast" ] || [ "$1" = "-3" ]; then
        forecast=1
        shift
    fi
    local loc="${1:-$default}"
    if [ "$forecast" -eq 1 ]; then
        curl -s "wttr.in/${loc}"
    else
        curl -s "wttr.in/${loc}?format=3"
    fi
}

# User-local binaries
export PATH="$HOME/.local/bin:$PATH"

# Google Cloud SDK
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi
