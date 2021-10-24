-- map helper
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
map('i', 'jk', '<Esc>')           -- jk to escape
