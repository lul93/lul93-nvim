-- file: lua/core/reveal/tags.lua

local M = {}

function M.setup()
	local effects = require("core.reveal.effects")

	local orig = vim.lsp.tagfunc

	_G._reveal_tagfunc = function(pattern, flags, info)
		print("[tagfunc] called")

		local result = orig(pattern, flags, info)

		vim.schedule(function()
			print("[tagfunc] effect")
			effects.run()
		end)

		return result
	end

	vim.o.tagfunc = "v:lua._reveal_tagfunc"
end

return M
