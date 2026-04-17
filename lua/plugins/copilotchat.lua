local enable = true
return {
	"CopilotChat.nvim",
	enabled = enable,
	beforeAll = function()
		require("bindings.copilotchat")
	end,
	after = function()
		require("config.copilotchat").setup()
	end,
}
