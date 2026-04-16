-- use fish if possible
if vim.fn.executable("fish") == 1 then
	vim.o.shell = "fish"
else
	vim.o.shell = "bash"
end

-- load our colors
require("core.colors.highlights").setup()
require("core.colors.mode_highlight").setup()

-- blink on revealing search results!
require("core.reveal.effects").setup({
	scroll_mode = "center",
	hl = "CursorLine",
	cycles = 2,
	persist = false,
})

require("core.reveal.lsp").setup()
require("core.reveal.jumplist").setup()
require("core.reveal.tags").setup()
require("core.reveal.search").setup()

-- insert when we enter a terminal
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(args)
		if vim.bo[args.buf].buftype ~= "terminal" then
			return
		end

		vim.schedule(function()
			if vim.api.nvim_get_current_buf() == args.buf then
				vim.cmd("startinsert")
			end
		end)
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function(args)
		vim.defer_fn(function()
			if vim.bo[args.buf].buftype == "terminal" then
				vim.cmd("startinsert")
			end
		end, 10)
	end,
})

-- emit a custom event after startup for lazy loading stuff
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "PostStartup" })
		end)
	end,
})

-- set title for kitty window
vim.opt.title = true

local function short_cwd()
	local cwd = vim.fn.getcwd()
	cwd = cwd:gsub(vim.env.HOME, "~")

	local parts = vim.split(cwd, "/")
	for i = 2, #parts - 1 do
		if #parts[i] > 0 then
			parts[i] = parts[i]:sub(1, 1)
		end
	end

	return table.concat(parts, "/")
end

vim.opt.titlestring = "%{v:lua.short_cwd()}"

vim.api.nvim_create_autocmd("DirChanged", {
	callback = function()
		vim.opt.titlestring = short_cwd()
	end,
})

_G.short_cwd = short_cwd
-- overwrite start screen
vim.opt.shortmess:append({ I = true })

vim.o.termguicolors = true -- enables 23 bit color

-- options ············································
vim.opt.clipboard = "unnamedplus" -- share system clipboard with nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true -- show absolute line number
vim.o.relativenumber = true -- show relative line numbers
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 499 -- how long nvim waits for a mapped key sequence to complete
vim.o.updatetime = 149 -- how often neovim considers you "idle" and triggers idle-based events
vim.opt.tabstop = 4 -- visual width of a tab
vim.opt.shiftwidth = 4 -- indentation size
vim.opt.softtabstop = 4 -- Tab inserts 2 spaces
vim.opt.expandtab = false -- convert tabs to spaces
vim.opt.cursorline = true -- highlight cursorline
-- vim.opt.cursorcolumn = true
vim.opt.autochdir = true
vim.o.autoindent = false
vim.o.smartindent = false
