local enable = true

return {
	"copilot.lua",
	enabled = enable,
	beforeAll = function()
		-- require("keymaps.copilot")
	end,
	event = "InsertEnter",
	after = function()
		-- copilot as language server ?
		-- require("copilot.lsp").setup()
		require("copilot").setup({
			suggestion = {
				enabled = false,
			},
			panel = {
				enabled = false,
			},
		})
		require("copilot_cmp").setup()
	end,
}
