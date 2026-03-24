return {
	"tabout.nvim",
	-- lazy = false,
	event = "VimEnter",
	beforeAll = function()
		-- require("keymaps.tabout")
	end,
	after = function()
		vim.schedule(function()
			require("config.tabout").setup()
		end)
	end,
}
