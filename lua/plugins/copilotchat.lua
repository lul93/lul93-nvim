local enable = true
return {
	"CopilotChat.nvim",
	enabled = enable,
	beforeAll = function()
		require("keymaps.copilotchat")
	end,
	event = { "User PostStartup" },
	after = function()
		require("config.copilotchat").setup()
	end,
}
