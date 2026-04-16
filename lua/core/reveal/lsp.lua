-- file: lua/core/reveal/lsp.lua

local M = {}

function M.setup()
	local effects = require("core.reveal.effects")

	local orig = vim.lsp.buf.definition

	vim.lsp.buf.definition = function(opts)
		opts = opts or {}

		local user_on_list = opts.on_list

		opts.on_list = function(result)
			if user_on_list then
				user_on_list(result)
			else
				vim.fn.setqflist({}, " ", result)
				vim.cmd("cfirst")
			end

			-- no ms delay, just next tick
			vim.schedule(function()
				effects.run()
			end)
		end

		return orig(opts)
	end
end

return M
