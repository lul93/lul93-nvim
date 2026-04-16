return {
	"persistence.nvim",
	beforeAll = function()
		require("keymaps.persistence")
	end,
	event = "VimEnter",
	after = function()
		require("config.persistence").setup()
	end,
}
