local lz = require("lz.n")
local keymap = lz.keymap("copilotchat")

local chat = require("config.copilotchat")

keymap.set({ "n", "v" }, "<leader>cc", function()
	chat.toggle()
end, { desc = "Copilot Chat: Toggle" })

-- Open explizit
keymap.set("n", "<leader>co", function()
	chat.open()
end, { desc = "Copilot Chat: Open" })

-- Close
keymap.set("n", "<leader>cx", function()
	chat.close()
end, { desc = "Copilot Chat: Close" })

-- Zurück zum Editor
keymap.set("n", "<leader>cb", function()
	chat.go_back()
end, { desc = "Copilot Chat: Back to editor" })

-- Neuer Chat
keymap.set("n", "<leader>cn", function()
	chat.open_new()
end, { desc = "Copilot Chat: New chat" })

keymap.set({ "n", "v" }, "<leader>ca", function()
	require("config.copilotchat").ask_with_context()
end, { desc = "Copilot Chat: Ask with context" })

vim.keymap.set("n", "<leader>cs", function()
	require("CopilotChat").stop()
end, { desc = "Copilot Chat: Stop" })
