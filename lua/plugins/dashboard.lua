return {
	"dashboard-nvim",
	-- TODO find a solution to the "1 frame flicker"
	-- lazy = false,
	init = function()
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = function()
				if vim.fn.argc() == 0 then
					vim.cmd("Dashboard")
				end
			end,
		})
	end,
	after = function()
		require("config.dashboard").setup()
	end,
}
