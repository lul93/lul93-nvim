local lz = require("lz.n")
local keymap = lz.keymap("nvim-tree.lua")

keymap.set("n", "<A-1>", function()
	vim.cmd.BufferGoto(1)
end)
keymap.set("n", "<A-2>", function()
	vim.cmd.BufferGoto(2)
end)
keymap.set("n", "<A-3>", function()
	vim.cmd.BufferGoto(3)
end)
keymap.set("n", "<A-4>", function()
	vim.cmd.BufferGoto(4)
end)
keymap.set("n", "<A-5>", function()
	vim.cmd.BufferGoto(5)
end)
keymap.set("n", "<A-6>", function()
	vim.cmd.BufferGoto(6)
end)
keymap.set("n", "<A-7>", function()
	vim.cmd.BufferGoto(7)
end)
keymap.set("n", "<A-8>", function()
	vim.cmd.BufferGoto(8)
end)
keymap.set("n", "<A-9>", function()
	vim.cmd.BufferGoto(9)
end)
keymap.set("n", "<A-w>", function()
	vim.cmd.BufferClose()
end)

-- reorder
keymap.set(
	"n",
	"<leader>bmp",
	"<Cmd>BufferMovePrevious<CR>",
	{ noremap = true, silent = true, desc = "move current buffer previous" }
)
keymap.set(
	"n",
	"<leader>bmn",
	"<Cmd>BufferMoveNext<CR>",
	{ noremap = true, silent = true, desc = "move current buffer next" }
)

--move
keymap.set("n", "<A-Tab>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })

keymap.set("n", "<A-S-Tab>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })

-- close
keymap.set(
	"n",
	"<leader>bl",
	"<Cmd>BufferCloseBuffersLeft<CR>",
	{ noremap = true, silent = true, desc = "close buffers to the left" }
)
keymap.set(
	"n",
	"<leader>br",
	"<Cmd>BufferCloseBuffersRight<CR>",
	{ noremap = true, silent = true, desc = "close buffers to the right" }
)
keymap.set("n", "<leader>bc", "<Cmd>BufferClose<CR>", { noremap = true, silent = true, desc = "close buffer" })
keymap.set(
	"n",
	"<leader>bC",
	"<Cmd>BufferClose<CR>",
	{ noremap = true, silent = true, desc = "close all other buffers" }
)

-- pin buffers
keymap.set("n", "<leader>bp", "<Cmd>BufferPin<CR>", { noremap = true, silent = true, desc = "toggle pin" })
keymap.set(
	"n",
	"<leader>bP",
	"<Cmd>BufferCloseAllButPinned<CR>",
	{ noremap = true, silent = true, desc = "delete non pinned buffers" }
)

-- order buffers
keymap.set(
	"n",
	"<leader>bob",
	"<Cmd>BufferOrderByBufferNumber<CR>",
	{ noremap = true, silent = true, desc = "order buffer by id" }
)

keymap.set(
	"n",
	"<leader>bon",
	"<Cmd>BufferOrderByName<CR>",
	{ noremap = true, silent = true, desc = "order buffer by name" }
)
keymap.set(
	"n",
	"<leader>bod",
	"<Cmd>BufferOrderByDirectory<CR>",
	{ noremap = true, silent = true, desc = "order buffer by dir" }
)

keymap.set(
	"n",
	"<leader>bol",
	"<Cmd>BufferOrderByLanguage<CR>",
	{ noremap = true, silent = true, desc = "order buffer by language" }
)

keymap.set(
	"n",
	"<leader>bol",
	"<Cmd>BufferOrderByWindowNumber<CR>",
	{ noremap = true, silent = true, desc = "order buffer by window number" }
)
