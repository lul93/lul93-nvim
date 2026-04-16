local enable = true

return {
	"telescope.nvim",
	enabled = enable,
	event = "VimEnter",
	beforeAll = function()
		require("keymaps.telescope")
	end,

	after = function()
		vim.schedule(function()
			require("config.telescope").setup()
		end)
	end,
}
