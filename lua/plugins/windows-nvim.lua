return {
	"windows.nvim",
	-- lazy = false,
	event = "User SessionLayoutReady",
	after = function()
		require("windows").setup({
			autowidth = {
				enable = true,
				winwidth = 1,
			},
		})
	end,
}
