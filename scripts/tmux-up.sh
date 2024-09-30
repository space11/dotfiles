#!/bin/bash

session="Work"

tmux new-session -d -s $session
tmux send-keys -t $session "cd ~/Projects/Work/upco/" Enter

window=1
tmux rename-window -t $session:$window "up"
tmux send-keys -t $session:$window "nvm use 20.17.0; nvim" C-m

window=2
tmux new-window -t $session:$window -n "lazy"
tmux send-keys -t $session "cd ~/Projects/Work/upco/" Enter
tmux send-keys -t $session:$window "lazygit" C-m

tmux attach-session -t $session
