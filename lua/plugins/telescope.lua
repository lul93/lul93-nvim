local enable = true

return {
	"telescope.nvim",
	enabled = enable,
	event = "User PostStartup",
	beforeAll = function()
		require("bindings.telescope")
	end,
	after = function()
		vim.schedule(function()
			require("config.telescope").setup()
		end)
	end,
}
