-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- U for "redo"
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Redo' })

-- ctrl + s to save
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save' })

-- ctrl + o go to previous open buffer b#
vim.keymap.set('n', '<C-o>', ':b#<CR>', { noremap = true, silent = true, desc = 'Go to previous open buffer' })
