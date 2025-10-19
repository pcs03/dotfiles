local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Remap spae as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--  normal_mode = "n"
--  insert_mode = "i"
--  visual_mode = "v"
--  visual_block_mode = "x"
--  term_mode = "t"
--  command_mode = "c"

-- Window splits
opts.desc = "Vertical Split"
keymap("n", "<leader>sv", "<C-w>v", opts)

opts.desc = "Horizontal Split"
keymap("n", "<leader>sh", "<C-w>s", opts)

opts.desc = "Close Split"
keymap("n", "<leader>sx", "<cmd>close<CR>", opts)

opts.desc = "Equalize Split"
keymap("n", "<leader>se", "<C-w>=", opts)

-- Better window navigation
opts.desc = "Move to Left Pane"
keymap("n", "<C-h>", "<C-w>h", opts)

opts.desc = "Move to Bottom Pane"
keymap("n", "<C-j>", "<C-w>j", opts)

opts.desc = "Move to Upper Pane"
keymap("n", "<C-k>", "<C-w>k", opts)

opts.desc = "Move to Right Pane"
keymap("n", "<C-l>", "<C-w>l", opts)


opts.desc = "Move to Left Pane"
keymap("n", "<C-Up>", "<C-w>k", opts)

opts.desc = "Move to Bottom Pane"
keymap("n", "<C-Down>", "<C-w>j", opts)

opts.desc = "Move to Upper Pane"
keymap("n", "<C-Left>", "<C-w>h", opts)

opts.desc = "Move to Right Pane"
keymap("n", "<C-Right>", "<C-w>l", opts)

-- Navigate buffers
opts.desc = "Next Buffer"
keymap("n", "<S-l>", ":bnext<CR>", opts)

opts.desc = "Previous Buffer"
keymap("n", "<S-h>", ":bprevious<CR>", opts)

opts.desc = "Next Buffer"
keymap("n", "<S-Right>", ":bnext<CR>", opts)

opts.desc = "Previous Buffer"
keymap("n", "<S-Left>", ":bprevious<CR>", opts)

-- Stay in indent mode
opts.desc = "Unindent"
keymap("v", "<", "<gv", opts)

opts.desc = "Indent"
keymap("v", ">", ">gv", opts)

-- Move text up and down
opts.desc = "Move Text Up"
keymap({"v", "x"}, "K", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Move Text Down"
keymap({"v", "x"}, "J", ":m '>+1<CR>gv=gv", opts)

opts.desc = "Move Text Up"
keymap({"v", "x"}, "<S-Up>", ":m '<-2<CR>gv=gv", opts)

opts.desc = "Move Text Down"
keymap({"v", "x"}, "<S-Down>", ":m '>+1<CR>gv=gv", opts)

-- Paste without polluting the register
opts.desc = "Paste"
keymap({"v", "x"}, "p", "\"_dP", opts)

-- Copy/Paste to the system clipboard
opts.desc = "Yank to System Clipboard"
keymap({"n", "v"}, "<leader>y", '"+y', opts)

opts.desc = "Paste from System Clipboard"
keymap({"n"}, "<leader>p", '"+P', opts)
keymap({"v"}, "<leader>p", '"+p', opts)

-- To make sure ctrl + C will always exit out of everything
opts.desc = "Escape"
keymap("i", "<C-c>", "<Esc>", opts)

-- Keep screen centered when jumping through search results
opts.desc = "Next Result"
keymap("n", "n", "nzzzv")

opts.desc = "Previous Result"
keymap("n", "N", "Nzzzv")

-- Vscode like ctrl+d-ish
opts.desc = "Select and replace word"
keymap("n", "<leader>j", "*``cgn", opts)

-- Never write chmod +x again!
opts.desc = "Make file executable"
keymap("n", "<leader>x", ":!chmod +x %<CR>")
