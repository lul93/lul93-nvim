return {
	"persistence.nvim",
	-- lazy = false,
	event = "VimEnter",
	after = function()
		require("config.persistence").setup()
	end,
}
