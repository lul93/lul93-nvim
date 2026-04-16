local enable = true

return {
	"focus-border",
	enabled = enable,
	event = "User PostStartup",
	after = function()
		require("core.focus_border").setup()
	end,
}
