local enable = true

local lz = require("lz.n")

-- prevent garbage suggestions on empty line
local has_words_before = function()
	local _, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	if col == 0 then
		return false
	end
	local text = vim.api.nvim_get_current_line()
	return text:sub(1, col):match("%S") ~= nil
end

local function setup()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load()
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "copilot", group_index = 2 },
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "neocmake" },
		},
		sorting = {
			priority_weight = 2,
			comparators = {
				require("cmp.config.compare").exact,
				require("copilot_cmp.comparators").prioritize,
				require("cmp.config.compare").score,
				require("cmp.config.compare").recently_used,
				require("cmp.config.compare").locality,
				require("cmp.config.compare").kind,
				require("cmp.config.compare").sort_text,
				require("cmp.config.compare").length,
				require("cmp.config.compare").order,
			},
		},
		mapping = {

			["<C-Space>"] = cmp.mapping.complete(),

			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end),

			["<Down>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end, { "i", "s" }),

			["<Up>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
				else
					fallback()
				end
			end, { "i", "s" }),

			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
	})
	-- insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

local function trigger_load_with_after(plugin_name)
	for _, dir in ipairs(vim.opt.packpath:get()) do
		local glob = vim.fs.joinpath("pack", "*", "opt", plugin_name)
		local plugin_dirs = vim.fn.globpath(dir, glob, nil, true, true)
		-- local plugin_dirs = vim.fn.globpath(dir, glob, false, true)
		if not vim.tbl_isempty(plugin_dirs) then
			lz.trigger_load(plugin_name)
			require("rtp_nvim").source_after_plugin_dir(plugin_dirs[1])
			return
		end
	end
end

return {
	"nvim-cmp",
	enabled = enable,
	event = "InsertEnter",
	after = function()
		local cmp_source_list = {
			"cmp-nvim-lsp",
			"cmp-buffer",
			"cmp_luasnip",
			"cmp-path",
			"cmp-cmdline",
			"cmp-nvim-lsp-signature-help",
			"cmp-nvim-lua",
			"clangd_extensions.nvim",
			"luasnip",
		}
		vim.iter(cmp_source_list):each(trigger_load_with_after)
		setup()
	end,
}
