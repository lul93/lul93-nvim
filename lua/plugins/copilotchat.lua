return {
	"CopilotChat.nvim",
	beforeAll = function()
		require("keymaps.copilotchat")
	end,
	event = { "User PostStartup" },
	after = function()
		require("config.copilotchat").setup()
	end,
}
