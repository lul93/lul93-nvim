local lz = require("lz.n")
local keymap = lz.keymap("copilotchat")
local map = require("keybinds").bind

local chat = require("config.copilotchat")

map(keymap, "copilotchat_toggle", function()
	chat.toggle()
end)

map(keymap, "copilotchat_open", function()
	chat.open()
end)

map(keymap, "copilotchat_close", function()
	chat.close()
end)

map(keymap, "copilotchat_back", function()
	chat.go_back()
end)

map(keymap, "copilotchat_new", function()
	chat.open_new()
end)

map(keymap, "copilotchat_ask", function()
	require("config.copilotchat").ask_with_context()
end)

map(keymap, "copilotchat_stop", function()
	require("CopilotChat").stop()
end)
