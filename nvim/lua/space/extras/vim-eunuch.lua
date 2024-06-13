-- Vim sugar for the UNIX shell commands that need it the most.
-- https://github.com/tpope/vim-eunuch
-- :Remove: Delete a file on disk without E211: File no longer available.
-- :Delete: Delete a file on disk and the buffer too.
-- :Move: Rename a buffer and the file on disk simultaneously. See also :Rename, :Copy, and :Duplicate.
-- :Chmod: Change the permissions of the current file.
-- :Mkdir: Create a directory, defaulting to the parent of the current file.
-- :Cfind: Run find and load the results into the quickfix list.
-- :Clocate: Run locate and load the results into the quickfix list.
-- :Lfind/:Llocate: Like above, but use the location list.
-- :Wall: Write every open window. Handy for kicking off tools like guard.
-- :SudoWrite: Write a privileged file with sudo.
-- :SudoEdit: Edit a privileged file with sudo.
-- Typing a shebang line causes the file type to be re-detected. Additionally the file will be automatically made executable (chmod +x) after the next write.
local M = { "tpope/vim-eunuch" }
return M
