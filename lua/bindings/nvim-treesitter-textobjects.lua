local lz = require("lz.n")
local keymap = lz.keymap("nvim-treesitter-textobjects")
local map = require("keybinds").bind

local move = require("nvim-treesitter-textobjects.move")
local select = require("nvim-treesitter-textobjects.select")

-- functions
map(keymap, "tsobj_next_function", function()
	move.goto_next_start("@function.outer", "textobjects")
end)

map(keymap, "tsobj_prev_function", function()
	move.goto_previous_start("@function.outer", "textobjects")
end)

-- classes
map(keymap, "tsobj_next_class", function()
	move.goto_next_start("@class.outer", "textobjects")
end)

map(keymap, "tsobj_prev_class", function()
	move.goto_previous_start("@class.outer", "textobjects")
end)

-- conditionals
map(keymap, "tsobj_next_conditional", function()
	move.goto_next("@conditional.outer", "textobjects")
end)

map(keymap, "tsobj_prev_conditional", function()
	move.goto_previous("@conditional.outer", "textobjects")
end)

-- parameters
map(keymap, "tsobj_next_parameter", function()
	move.goto_next("@parameter.outer", "textobjects")
end)

map(keymap, "tsobj_prev_parameter", function()
	move.goto_previous("@parameter.outer", "textobjects")
end)

-- arguments
map(keymap, "tsobj_next_argument", function()
	move.goto_next("@argument.outer", "textobjects")
end)

map(keymap, "tsobj_prev_argument", function()
	move.goto_previous("@argument.outer", "textobjects")
end)

-- classes
map(keymap, "tsobj_select_class_outer", function()
	select.select_textobject("@class.outer", "textobjects")
end)

map(keymap, "tsobj_select_class_inner", function()
	select.select_textobject("@class.inner", "textobjects")
end)

-- scope
map(keymap, "tsobj_select_scope", function()
	select.select_textobject("@local.scope", "locals")
end)

-- parameters
map(keymap, "tsobj_select_param_inner", function()
	select.select_textobject("@parameter.inner", "textobjects")
end)

map(keymap, "tsobj_select_param_outer", function()
	select.select_textobject("@parameter.outer", "textobjects")
end)

-- arguments
map(keymap, "tsobj_select_arg_inner", function()
	select.select_textobject("@argument.inner", "textobjects")
end)

map(keymap, "tsobj_select_arg_outer", function()
	select.select_textobject("@argument.outer", "textobjects")
end)

-- functions
map(keymap, "tsobj_select_func_inner", function()
	select.select_textobject("@function.inner", "textobjects")
end)

map(keymap, "tsobj_select_func_outer", function()
	select.select_textobject("@function.outer", "textobjects")
end)

-- conditionals
map(keymap, "tsobj_select_cond_inner", function()
	select.select_textobject("@conditional.inner", "textobjects")
end)

map(keymap, "tsobj_select_cond_outer", function()
	select.select_textobject("@conditional.outer", "textobjects")
end)

-- loops
map(keymap, "tsobj_select_loop_inner", function()
	select.select_textobject("@loop.inner", "textobjects")
end)

map(keymap, "tsobj_select_loop_outer", function()
	select.select_textobject("@loop.outer", "textobjects")
end)
