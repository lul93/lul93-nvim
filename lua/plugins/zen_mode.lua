return {
	"zen-mode.nvim",
	keys = { "<leader>tz" },
	after = function()
		require("config.zen_mode").setup()
		require("keymaps.zen_mode")
	end,
}
