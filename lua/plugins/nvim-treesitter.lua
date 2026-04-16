local enable = true
local function setup()
	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

	-- we preload all parsers via nix packages
	vim.api.nvim_create_autocmd("FileType", {
		callback = function(ev)
			if vim.bo[ev.buf].buftype ~= "" then
				return
			end

			local ft = vim.bo[ev.buf].filetype
			local lang = vim.treesitter.language.get_lang(ft)
			if not lang then
				return
			end

			-- redundant?
			if not pcall(vim.treesitter.language.add, lang) then
				return
			end

			pcall(vim.treesitter.start, ev.buf)

			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

			local win = vim.api.nvim_get_current_win()
			vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[win].foldmethod = "expr"

			-- fix this later
			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
	})
end

return {
	"nvim-treesitter",
	enabled = enable,
	lazy = false,
	after = function()
		setup()
	end,
}
