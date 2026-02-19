-- emit a user event after startup
-- vim.schedule(function()
-- 	vim.api.nvim_exec_autocmds("User", { pattern = "PostStartup" })
-- end)

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "PostStartup" })
		end)
	end,
})
-- resize on os window resize
local esplits = vim.api.nvim_create_augroup("EqualizeSplits", { clear = true })
vim.api.nvim_create_autocmd("VimResized", {
	group = esplits,
	callback = function()
		vim.cmd.wincmd("=")
	end,
})

-- set title for terminal window
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

-- doom colorscheme
vim.o.termguicolors = true -- enables 23 bit color
vim.g.doom_one_cursor_coloring = false
vim.g.doom_one_terminal_colors = true
vim.g.doom_one_italic_comments = false
vim.g.doom_one_enable_treesitter = true
vim.g.doom_one_diagnostics_text_color = false
vim.g.doom_one_transparent_background = false

vim.g.doom_one_pumblend_enable = false
vim.g.doom_one_pumblend_transparency = 20

-- vim.g.doom_one_plugin_neorg = true
vim.g.doom_one_plugin_barbar = true
vim.g.doom_one_plugin_telescope = false
vim.g.doom_one_plugin_neogit = true
vim.g.doom_one_plugin_nvim_tree = true
vim.g.doom_one_plugin_dashboard = true
vim.g.doom_one_plugin_whichkey = true
vim.g.doom_one_plugin_indent_blankline = true
-- vim.g.doom_one_plugin_vim_illuminate = true
-- vim.g.doom_one_plugin_lspsaga = false

vim.cmd.colorscheme("doom-one")

vim.api.nvim_set_hl(0, "BufferCurrent", {
	fg = "#282c34",
	bg = "#51afef",
	bold = true,
})

vim.api.nvim_set_hl(0, "BufferCurrentSign", {
	fg = "#51afef",
	bg = "#21242b",
})

vim.api.nvim_set_hl(0, "BufferTabpageFill", {
	bg = "#1c1f24",
})
vim.api.nvim_set_hl(0, "BufferInactive", {
	fg = "#5B6268",
	bg = "#1c1f24",
})

vim.api.nvim_set_hl(0, "BufferVisible", {
	fg = "#bbc2cf",
	bg = "#23272e",
})
-- options ············································
vim.opt.clipboard = "unnamedplus" -- share system clipboard with nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true -- show absolute line number
vim.o.relativenumber = true -- show relative line numbers
vim.o.signcolumn = "yes"
vim.o.timeoutlen = 499 -- how long nvim waits for a mapped key sequence to complete
vim.o.updatetime = 149 -- how often neovim considers you "idle" and triggers idle-based events
vim.opt.tabstop = 1 -- visual width of a tab
vim.opt.shiftwidth = 1 -- indentation size
vim.opt.softtabstop = 1 -- Tab inserts 2 spaces
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.cursorline = true -- highlight cursorline
-- vim.opt.cursorcolumn = true
vim.opt.autochdir = true
vim.o.autoindent = false
vim.o.smartindent = false
