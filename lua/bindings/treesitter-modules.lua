local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")
local map = require("keybinds").bind

local ts = require("treesitter-modules")

map(keymap, "tsmod_init", ts.init_selection)
map(keymap, "tsmod_inc", ts.node_incremental)
map(keymap, "tsmod_dec", ts.node_decremental)
map(keymap, "tsmod_scope", ts.scope_incremental)
