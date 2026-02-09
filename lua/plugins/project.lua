return {
	"project.nvim",
	-- lazy = false,
	-- event = { "BufReadPre", "BufNewFile" },
	event = "VimEnter",
	after = function()
		require("config.project").setup()
	end,
}
