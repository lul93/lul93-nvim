local lz = require("lz.n")
local keymap = lz.keymap("nvim-treesitter-textobjects")
local move = require("nvim-treesitter-textobjects.move")

-- functions
keymap.set({ "n", "x", "o" }, "]f", function()
	move.goto_next_start("@function.outer", "textobjects")
end, { desc = "go to next function" })

keymap.set({ "n", "x", "o" }, "[f", function()
	move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "go to previous function" })

-- classes
keymap.set({ "n", "x", "o" }, "]c", function()
	move.goto_next_start("@class.outer", "textobjects")
end, { desc = "go to next class" })

keymap.set({ "n", "x", "o" }, "[c", function()
	move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "go to previous class" })

-- conditionals
keymap.set({ "n", "x", "o" }, "]i", function()
	move.goto_next("@conditional.outer", "textobjects")
end, { desc = "go to next conditional" })

keymap.set({ "n", "x", "o" }, "[i", function()
	move.goto_previous("@conditional.outer", "textobjects")
end, { desc = "go to previous conditional" })

-- parameters
keymap.set({ "n", "x", "o" }, "]a", function()
	move.goto_next("@parameter.outer", "textobjects")
end, { desc = "go to next parameter" })

keymap.set({ "n", "x", "o" }, "[a", function()
	move.goto_previous("@parameter.outer", "textobjects")
end, { desc = "go to previous parameter" })

-- arguments (function calls)
keymap.set({ "n", "x", "o" }, "]A", function()
	move.goto_next("@argument.outer", "textobjects")
end, { desc = "go to next argument" })

keymap.set({ "n", "x", "o" }, "[A", function()
	move.goto_previous("@argument.outer", "textobjects")
end, { desc = "go to previous argument" })

local select = require("nvim-treesitter-textobjects.select")

-- classes
keymap.set({ "x", "o" }, "ac", function()
	select.select_textobject("@class.outer", "textobjects")
end, { desc = "select around class" })

keymap.set({ "x", "o" }, "ic", function()
	select.select_textobject("@class.inner", "textobjects")
end, { desc = "select inside class" })

-- local scope
keymap.set({ "x", "o" }, "as", function()
	select.select_textobject("@local.scope", "locals")
end, { desc = "select around local scope" })

-- parameters (function definition)
keymap.set({ "o", "x" }, "ip", function()
	select.select_textobject("@parameter.inner", "textobjects")
end, { desc = "select inside parameter" })

keymap.set({ "o", "x" }, "ap", function()
	select.select_textobject("@parameter.outer", "textobjects")
end, { desc = "select around parameter" })

-- arguments (function call)
keymap.set({ "o", "x" }, "ia", function()
	select.select_textobject("@argument.inner", "textobjects")
end, { desc = "select inside argument" })

keymap.set({ "o", "x" }, "aa", function()
	select.select_textobject("@argument.outer", "textobjects")
end, { desc = "select around argument" })

-- functions
keymap.set({ "o", "x" }, "if", function()
	select.select_textobject("@function.inner", "textobjects")
end, { desc = "select inside function" })

keymap.set({ "o", "x" }, "af", function()
	select.select_textobject("@function.outer", "textobjects")
end, { desc = "select around function" })

-- conditionals
keymap.set({ "o", "x" }, "ii", function()
	select.select_textobject("@conditional.inner", "textobjects")
end, { desc = "select inside conditional" })

keymap.set({ "o", "x" }, "ai", function()
	select.select_textobject("@conditional.outer", "textobjects")
end, { desc = "select around conditional" })

-- loops
keymap.set({ "o", "x" }, "il", function()
	select.select_textobject("@loop.inner", "textobjects")
end, { desc = "select inside loop" })

keymap.set({ "o", "x" }, "al", function()
	select.select_textobject("@loop.outer", "textobjects")
end, { desc = "select around loop" })
