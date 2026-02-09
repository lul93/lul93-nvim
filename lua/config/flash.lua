local M = {}

function M.setup()
 require("flash").setup({
  labels = "asdfghjklqwertyuiopzxcvbnm",
  search = {
   multi_window = true,
   forward = true,
   wrap = true,
   incremental = true,
  },
  jump = {
   autojump = true,
  },
  modes = {
   search = {
    enabled = true,
   },
   char = {
    enabled = true,
    jump_labels = true,
   },
  },
  highlight = {
   backdrop = true,
  },
 })
end

return M
