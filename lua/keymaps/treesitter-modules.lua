local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")
local ts = require("treesitter-modules")

keymap.set("n", "<CR>", ts.init_selection, { silent = true })
keymap.set("x", "<Tab>", ts.node_incremental, { silent = true })
keymap.set("x", "<S-Tab>", ts.node_decremental, { silent = true })
keymap.set("x", "<CR>", ts.scope_incremental, { silent = true })
