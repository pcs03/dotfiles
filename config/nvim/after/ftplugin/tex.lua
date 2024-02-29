vim.opt.wrap = true
vim.opt.bri = true
vim.opt.linebreak = true

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")

local npairs = require("nvim-autopairs")
local nrule = require("nvim-autopairs.rule")

npairs.remove_rule("\'")
npairs.remove_rule("\"")

npairs.add_rules({
    nrule("$", "$", "tex"),
})
