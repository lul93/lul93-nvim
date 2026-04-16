local M = {}

local config = {
	scroll_mode = "center",
	hl = "CursorLine",
	cycles = 2,
	persist = false,
}

function M.setup(opts)
	config = vim.tbl_extend("force", config, opts or {})

	local effects = require("core.reveal.effects")
	effects.setup(config)

	local set = vim.keymap.set

	set("c", "<CR>", function()
		local is_search = vim.fn.getcmdtype() == "/"

		if is_search then
			vim.schedule(effects.run)
		end

		return "<CR>"
	end, { expr = true })

	set("n", "n", function()
		local ok = pcall(vim.cmd.normal, { "n", bang = true })

		if ok then
			vim.schedule(effects.run)
		end
	end, { silent = true })

	set("n", "N", function()
		local ok = pcall(vim.cmd.normal, { "N", bang = true })

		if ok then
			vim.schedule(effects.run)
		end
	end, { silent = true })

	set("n", "<leader>/", vim.cmd.nohlsearch, {
		silent = true,
		desc = "Clear search highlight",
	})
end

return M
