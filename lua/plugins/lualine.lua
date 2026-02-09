return {
	"lualine.nvim",
	-- event = { "BufReadPre", "BufNewFile" },
	event = { "User PostStartup" },
	after = {
		require("config.lualine").setup(),
	},
}
