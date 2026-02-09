return {
	"which-key.nvim",
	event = "User PostStartup",
	after = function()
		require("config.which-key").setup()
	end,
}
