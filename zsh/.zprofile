# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/borysolenjniczak/.docker/bin"
# End of Docker Desktop section.

eval "$(/opt/homebrew/bin/brew shellenv)"

# Run brew with umask 002 so files stay group-writable for the shared
# brewgroup setup (daily user + Borys.admin both modify /opt/homebrew).
umask 002

export EDITOR="nvim"

# Setting PATH for Python 3.13
PATH="/Library/Frameworks/Python.framework/Versions/3.13/bin:${PATH}"
export PATH
