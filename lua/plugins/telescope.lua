return {
	"telescope.nvim",
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
