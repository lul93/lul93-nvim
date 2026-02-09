local lz = require("lz.n")

local function trigger_load_with_after(plugin_name)
	for _, dir in ipairs(vim.opt.packpath:get()) do
		local glob = vim.fs.joinpath("pack", "*", "opt", plugin_name)
		local plugin_dirs = vim.fn.globpath(dir, glob, nil, true, true)
		-- local plugin_dirs = vim.fn.globpath(dir, glob, false, true)
		if not vim.tbl_isempty(plugin_dirs) then
			lz.trigger_load(plugin_name)
			require("rtp_nvim").source_after_plugin_dir(plugin_dirs[1])
			return
		end
	end
end

return {
	"nvim-cmp",
	event = "InsertEnter",
	after = function()
		local rtp = require("rtp_nvim")
		local cmp_source_list = {
			"cmp-nvim-lsp",
			"cmp-buffer",
			"cmp_luasnip",
			"cmp-path",
			"cmp-cmdline",
			"cmp-nvim-lsp-signature-help",
			"cmp-nvim-lua",
			"clangd_extensions.nvim",
			"luasnip",
		}
		vim.iter(cmp_source_list):each(trigger_load_with_after)
		require("config.nvim-cmp").setup()
	end,
}
