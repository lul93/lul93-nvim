local M = {}

function M.run(winid, line, mode)
	-- validate window early
	if not vim.api.nvim_win_is_valid(winid) then
		return
	end

	local height = vim.api.nvim_win_get_height(winid)
	if height < 1 then
		return
	end

	-- compute desired topline
	local topline
	if mode == "center" then
		topline = line - math.floor(height / 2)
	else
		-- default + "top"
		topline = line
	end

	vim.schedule(function()
		if not vim.api.nvim_win_is_valid(winid) then
			return
		end

		local bufnr = vim.api.nvim_win_get_buf(winid)
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		local max = vim.api.nvim_buf_line_count(bufnr)

		-- clamp topline to valid range
		topline = math.max(1, math.min(topline, max))

		vim.api.nvim_win_call(winid, function()
			local view = vim.fn.winsaveview()

			-- only modify scroll position
			view.topline = topline

			vim.fn.winrestview(view)
		end)
	end)
end

return M
