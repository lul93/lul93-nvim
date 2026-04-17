local enable = true

return {
	"nvim-surround",
	enabled = enable,
	event = "User PostStartup",
	after = function()
		require("nvim-surround").setup()
	end,
}
