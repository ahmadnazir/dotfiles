-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save File" })

-- Spacemacs-style keybindings
-- <leader>wm (maximize/zoom window) and <leader>wd (delete window) are already
-- LazyVim defaults that match `SPC w m` / `SPC w d` in Spacemacs, so no remap needed here.

vim.keymap.set("n", "<leader>pf", LazyVim.pick("files"), { desc = "Find File (Project)" })
vim.keymap.set("n", "<leader>sp", LazyVim.pick("live_grep"), { desc = "Search Project" })

-- ctrl+shift+/ also opens the project file picker, matching the herdr session
-- navigator and Emacs. Only <C-S-/> is mapped: <C-?> is 0x7f (DEL) in Vim's
-- keycode notation, not this chord. <C-/> stays free for LazyVim's terminal
-- toggle, which encodes differently.
vim.keymap.set("n", "<C-S-/>", LazyVim.pick("files"), { desc = "Find File (Project)" })

vim.keymap.set("n", "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Tab" })
vim.keymap.set("n", "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Tab" })
