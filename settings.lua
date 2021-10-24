local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function settings(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

local cmd = vim.cmd
local indent = 4

cmd 'syntax enable'
cmd 'filetype plugin indent on'
settings('b', 'shiftwidth', indent)
settings('b', 'tabstop', indent)
settings('o', 'hidden', true) -- enable background buffers
settings('o', 'ignorecase', true)
settings('o', 'joinspaces', false) -- no double space with join
settings('o', 'list', true) -- eshow invisible characters
settings('o', 'scrolloff', 4 ) -- lines of context
settings('o', 'shiftround', true) -- round indent
settings('o', 'shiftwidth', 4) -- size of indent
settings('o', 'smartcase', true) -- no not ignore cases of capitals
settings('b', 'smartindent', true) -- insert indent automatically
settings('o', 'splitbelow', true)
settings('o', 'splitright', true)
settings('o', 'tabstop', 4)
settings('o', 'wildmode', 'list:longest') -- commandline copletion mode	
settings('w', 'number', true)
settings('w', 'wrap', false) -- disable line wrap
settings('o', 'clipboard','unnamed,unnamedplus')
settings('o', 'termguicolors',true) -- true color support


-- settings('w', 'relativenumber', true)
-- settings('b', 'expandtab', true) -- use space instead of tabs

-- Highlight on yank
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
