local lz = require("lz.n")
local keymap = lz.keymap("hop.nvim")
local map = require("keybinds").bind

local hop = require("hop")
local directions = require("hop.hint").HintDirection

map(keymap, "hop_f", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })

map(keymap, "hop_F", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })

map(keymap, "hop_t", function()
	hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })

map(keymap, "hop_T", function()
	hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
