vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.inccommand = "split"
vim.opt.laststatus = 2
vim.opt.listchars = { tab = "»-", trail = "-", nbsp = "+" }
vim.opt.numberwidth = 5
vim.opt.path:append({ "**" })
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.showcmd = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.wrap = false
vim.opt.wrapscan = true
