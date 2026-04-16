return {
	"focus-border",
	event = "User PostStartup",
	after = function()
		require("core.focus_border").setup()
	end,
}
