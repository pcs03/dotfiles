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

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", "<C-w>k", opts)
keymap("n", "<C-Down>", "<C-w>j", opts)
keymap("n", "<C-Left>", "<C-w>h", opts)
keymap("n", "<C-Right>", "<C-w>l", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-Right>", ":bnext<CR>", opts)
keymap("n", "<S-Left>", ":bprevious<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap({"v", "x"}, "K", ":m '<-2<CR>gv=gv", opts)
keymap({"v", "x"}, "J", ":m '>+1<CR>gv=gv", opts)
keymap({"v", "x"}, "<S-Up>", ":m '<-2<CR>gv=gv", opts)
keymap({"v", "x"}, "<S-Down>", ":m '>+1<CR>gv=gv", opts)

-- Paste without polluting the register
keymap({"v", "x"}, "p", "\"_dP", opts)

-- Copy/Paste to the system clipboard
opts.desc = "Yank to system clipboard"
keymap({"n", "v"}, "<leader>y", [["+y"]], opts)

opts.desc = "Yank line to system clipboard"
keymap("n", "<leader>Y", [["+Y"]], opts)

opts.desc = "Paste from system clipboard"
keymap({"n", "v"}, "<leader>p", [["+p"]], opts)

-- Q to split one long line into separate lines
keymap("n", "Q", "gw", opts)

-- To make sure ctrl + C will always exit out of everything
keymap("i", "<C-c>", "<Esc>", opts)

-- Page up and down with recenter
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Keep screen centered when jumping through search results
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Vscode like ctrl+d-ish
opts.desc = "Select and replace word"
keymap("n", "<leader>j", "*``cgn", opts)

-- Never write chmod +x again!
opts.desc = "Make file executable"
keymap("n", "<leader>x", ":!chmod +x %<CR>")
