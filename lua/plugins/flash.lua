return {
	"flash.nvim",
	beforeAll = function()
		require("keymaps.flash")
	end,
	keys = { "s" },
	after = function()
		require("config.flash").setup()
	end,
}
