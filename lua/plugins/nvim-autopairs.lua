local enable = true

return {
	"nvim-autopairs",
	enabled = enable,
	event = "InsertEnter",
	after = function()
		require("nvim-autopairs").setup()
	end,
}
