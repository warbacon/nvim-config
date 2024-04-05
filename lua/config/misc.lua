-- Disable banner in netrw
vim.g.netrw_banner = 0

-- Remove the "How-to disable mouse" menu item and the separator above it
vim.cmd([[
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-
]])
