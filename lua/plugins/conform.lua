return {
	"conform.nvim",
	beforeAll = function()
		require("keymaps.conform")
	end,
	event = { "BufWritePre" },
	after = function()
		require("config.conform").setup()
	end,
}
