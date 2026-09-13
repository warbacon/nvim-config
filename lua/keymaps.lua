-- Find files
vim.keymap.set("n", "<Leader><Leader>", ":find **/", { noremap = true, desc = "Find files" })

-- Move around quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>", { noremap = true, desc = "Go to previous quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>", { noremap = true, desc = "Go to next quickfix item" })

-- Move line up
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Move line down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })

-- Copy to clipboard
vim.keymap.set("v", "<Leader>y", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<Leader>yy", '"+yy', { desc = "Copy line to system clipboard" })

-- Move cursor to start of commandline
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true, desc = "Move cursor to start of commandline" })

-- Fix common typos: :W, :Wq, :Q
vim.api.nvim_create_user_command("W", "w", { bang = true, desc = "Alias for :w" })
vim.api.nvim_create_user_command("Wq", "wq", { bang = true, desc = "Alias for :wq" })
vim.api.nvim_create_user_command("Q", "q", { bang = true, desc = "Alias for :q" })

-- Go to definition
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buf = ev.buf, desc = "Go to definition" })
	end,
})
