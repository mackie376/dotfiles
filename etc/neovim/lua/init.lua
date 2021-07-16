local utils = require('utils')
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

-- -------------------------------------------------------------------------

cmd('filetype indent plugin off')
cmd('syntax off')

-- -------------------------------------------------------------------------

utils.option('o', 'clipboard',      'unnamed,unnamedplus')
utils.option('o', 'cmdheight',      2)
utils.option('o', 'completeopt',    'menuone,noinsert,noselect')
utils.option('o', 'fileencodings',  'ucs-bombs,utf-8,euc-jp,cp932')
utils.option('o', 'fileformats',    'unix,mac,dos')
utils.option('o', 'guicursor',      '')
utils.option('o', 'hidden',         true)
utils.option('o', 'ignorecase',     true)
utils.option('o', 'laststatus',     2)
utils.option('o', 'mouse',          'a')
utils.option('o', 'pumblend',       10)
utils.option('o', 'scrolloff',      5)
utils.option('o', 'showmode',       false)
utils.option('o', 'smartcase',      true)
utils.option('o', 'termguicolors',  true)
utils.option('o', 'timeoutlen',     1000)
utils.option('o', 'ttimeoutlen',    1)
utils.option('o', 'updatetime',     200)
utils.option('o', 'visualbell',     true)
utils.option('o', 'whichwrap',      'b,s,<,>,[,]')
utils.option('o', 'winblend',       10)
utils.option('o', 'wrapscan',       true)

utils.option('w', 'cursorline',     true)
utils.option('w', 'list',           true)
utils.option('w', 'listchars',      'tab:» ,trail:-')
utils.option('w', 'number',         true)
utils.option('w', 'numberwidth',    5)
utils.option('w', 'relativenumber', true)
utils.option('w', 'signcolumn',     'yes')

utils.option('b', 'expandtab',      true)
utils.option('b', 'shiftwidth',     2)
utils.option('b', 'smartindent',    true)
utils.option('b', 'softtabstop',    2)
utils.option('b', 'swapfile',       false)
utils.option('b', 'tabstop',        2)

cmd('set shortmess+=c')

-- -------------------------------------------------------------------------

vim.g.mapleader = ' '

utils.map('n', '[bookmark]', '<nop>', { silent = false })
utils.map('n', '[buffer]',   '<nop>', { silent = false })
utils.map('n', '[execute]',  '<nop>', { silent = false })
utils.map('n', '[file]',     '<nop>', { silent = false })
utils.map('n', '[git]',      '<nop>', { silent = false })
utils.map('n', '[language]', '<nop>', { silent = false })
utils.map('n', '[project]',  '<nop>', { silent = false })
utils.map('n', '[quit]',     '<nop>', { silent = false })
utils.map('n', '[search]',   '<nop>', { silent = false })

utils.map('n', '<leader>b', '[buffer]',   { noremap = false, silent = false })
utils.map('n', '<leader>f', '[file]',     { noremap = false, silent = false })
utils.map('n', '<leader>g', '[git]',      { noremap = false, silent = false })
utils.map('n', '<leader>l', '[language]', { noremap = false, silent = false })
utils.map('n', '<leader>m', '[bookmark]', { noremap = false, silent = false })
utils.map('n', '<leader>p', '[project]',  { noremap = false, silent = false })
utils.map('n', '<leader>q', '[quit]',     { noremap = false, silent = false })
utils.map('n', '<leader>s', '[search]',   { noremap = false, silent = false })
utils.map('n', '<leader>x', '[execute]',  { noremap = false, silent = false })

utils.map('n', '<esc><esc>', '<cmd>nohlsearch<Cr><esc>')
utils.map('n', 's',          '<nop>')
utils.map('n', 's/',         '<cmd>vs<Cr>')
utils.map('n', 's-',         '<cmd>vs<Cr>')
utils.map('n', 'sc',         '<c-w>c')
utils.map('n', 'sd',         '<c-w>c')
utils.map('n', 'sh',         '<c-w>h')
utils.map('n', 'sj',         '<c-w>j')
utils.map('n', 'sk',         '<c-w>k')
utils.map('n', 'sl',         '<c-w>l')
utils.map('n', 'so',         '<c-w>o')
utils.map('n', 'ss',         '<c-w>w')
utils.map('n', 'x',          '"_x')
utils.map('n', 'D',          '"_D')
utils.map('n', '[buffer]d',  '<cmd>bw<Cr>')
utils.map('n', '[buffer]n',  '<cmd>bn<Cr>')
utils.map('n', '[buffer]p',  '<cmd>bp<Cr>')
utils.map('n', '[execute]s', '<cmd>term<Cr>')
utils.map('n', '[file]s',    '<cmd>w<Cr>')
utils.map('n', '[quit]Q',    '<cmd>qall!<Cr>')
utils.map('n', '[quit]q',    '<cmd>wqall<Cr>')

utils.map('i', 'jk',         '<esc>')

utils.map('t', '<c-g>',      '<c-\\><c-n>')

-- -------------------------------------------------------------------------

function remove_trailing_whitespace()
  local pos = vim.api.nvim_win_get_cursor(0)
  cmd('%s/ \\+$//ge')
  vim.api.nvim_win_set_cursor(0, pos)

  if vim.api.nvim_buf_line_count(0) > 1 then
    while vim.api.nvim_buf_get_lines(0, -2, -1, true)[1] == '' do
      vim.api.nvim_buf_set_lines(0, -2, -1, true, {})
    end
  end
end

function on_termopen()
  utils.option('w', 'number',         false)
  utils.option('w', 'relativenumber', false)
  cmd('startinsert')
end

-- -------------------------------------------------------------------------

local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_path)) > 0 then
  fn.system({ 'git', 'clone', 'https://github.com/wbthomason/packer.nvim', packer_path })
  api.nvim_command('packadd packer.nvim')
end

require('plugins')

-- -------------------------------------------------------------------------

cmd('autocmd BufWritePre * lua remove_trailing_whitespace()')
cmd('autocmd TextYankPost * lua vim.highlight.on_yank { timeout = 100 }')
cmd('autocmd TermOpen * lua on_termopen()')
cmd('autocmd BufWritePost plugins.lua source <afile> | PackerCompile')

-- -------------------------------------------------------------------------

cmd('filetype indent plugin on')
cmd('syntax on')
