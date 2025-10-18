-----------------------------------------------------------
-- General
-----------------------------------------------------------
-- Set leader key to space
vim.g.mapleader = " "
-- Set leader key to space
vim.g.maplocalleader = " "

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

--Clipboard
vim.opt.clipboard:append("unnamedplus")
vim.o.hlsearch = true
vim.o.winborder = "rounded"

-- Number of spaces a tab represents
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Use appropriate when using indent command
vim.o.expandtab = true
vim.o.shiftwidth = 2

-- Indenting correctly after { etc
vim.o.smartindent = true

-- Copy indent from current line when starting new line
vim.o.autoindent = true

-- Prevent line wrapping
vim.o.breakindent = true

-- Disable text wrap
vim.o.wrap = false

-- Speeds up plugin wait time
vim.o.updatetime = 50

vim.o.inccommand = "split"

-----------------------------------------------------------
-- UI Config
-----------------------------------------------------------
-- Enable line numbers
vim.o.nu = true

-- Enable relative line numbers
vim.o.rnu = true

-- Disable showing the mode below the statusline
vim.o.showmode = false

-- Better completion experience
vim.opt.completeopt.e = { "menuone", "noselect" }

-- Enable 24-bit color
vim.o.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.o.signcolumn = "yes"

-- Enable cursor line highlight
vim.o.cursorline = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.o.scrolloff = 8

-- Better splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Disable swapfiles
vim.o.swapfile = false

-- Highlight yank
vim.api.nvim_create_autocmd("textyankpost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	desc = "highlight selection on yank",
	callback = function()
		vim.highlight.on_yank({ timeout = 200, visual = true })
	end,
})

-----------------------------------------------------------
-- Search Config
-----------------------------------------------------------
-- Enable highlighting search in progress
vim.o.incsearch = true

-- Ignore case for searches
vim.o.ignorecase = true
vim.o.smartcase = true

-- Diagnostic display inline
vim.diagnostic.config({
	virtual_text = true,
	underline = true,
})
