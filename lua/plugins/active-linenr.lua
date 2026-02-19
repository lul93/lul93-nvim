return {
	"active_linenr",
	event = "User PostStartup",
	after = function()
		require("core.active-linenumber").setup()
	end,
}
