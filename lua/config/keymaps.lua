M = {}
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- U for "redo"
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Redo' })

-- ctrl + s to save
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save' })

-- ctrl + o go to previous open buffer b#
vim.keymap.set('n', '<C-o>', ':b#<CR>', { noremap = true, silent = true, desc = 'Go to previous open buffer' })

-- yank
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')

vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')

local function map_normal_mode(keys, func, desc)
  -- default values:
  -- noremap: false
  -- silent: false
  vim.keymap.set('n', keys, func, { desc = desc, noremap = false, silent = true })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

function M.setup_spectre_keymaps()
  map_normal_mode('<leader>spt', ":lua require('spectre').toggle()<CR>", '[s][p]ectre [t]oggle')
  map_normal_mode('<leader>spw', ":lua require('spectre').open_visual({select_word=true})<CR>", '[s][p]ectre current [w]ord')
  map_normal_mode('<leader>spf', ':lua require("spectre").open_file_search({select_word=true})<CR>', '[s][p]ectre current [f]ile')
end

function M.setup_ufo_keymaps()
  map_normal_mode('<C-f>', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of coc.nvim and nvim lsp
      vim.fn.CocActionAsync 'definitionHover' -- coc.nvim
      vim.lsp.buf.hover()
    end
  end, 'Peek Folded Lines Under Cursor')
end

function M.setup_gitsigns_keymaps(bufnr)
  local gs = package.loaded.gitsigns

  vim.keymap.set('n', ']c', function()
    if vim.wo.diff then
      return ']c'
    end
    vim.schedule(function()
      gs.next_hunk()
    end)
    return '<Ignore>'
  end, { expr = true })

  vim.keymap.set('n', '[c', function()
    if vim.wo.diff then
      return '[c'
    end
    vim.schedule(function()
      gs.prev_hunk()
    end)
    return '<Ignore>'
  end, { expr = true })

  vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { buffer = bufnr, silent = true, noremap = true, desc = '[s]tage hunk' })
  vim.keymap.set({ 'n', 'v' }, '<leader>hS', ':Gitsigns stage_buffer<CR>', { buffer = bufnr, silent = true, noremap = true, desc = '[S]tage buffer' })
  vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[u]ndo stage hunk' })
  vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[r]eset hunk' })
  vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, silent = true, noremap = true, desc = '[R]eset buffer' })
  vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[p]review hunk' })
  vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, silent = true, noremap = true, desc = '[d]iff this' })

  vim.keymap.set('n', '<leader>hD', function()
    gs.diffthis '~'
  end, { buffer = bufnr, silent = true, noremap = true, desc = '[D]iff this ~' })

  vim.keymap.set('n', '<leader>hb', function()
    gs.blame_line { full = true }
  end, { buffer = bufnr, silent = true, noremap = true, desc = '[d]iff this' })

  vim.keymap.set('n', '<leader>hB', gs.toggle_current_line_blame, { buffer = bufnr, silent = true, noremap = true, desc = 'Toggle line [B]lame' })
end

function M.setup_whichkey()
  return {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = '[T]ypeScript', _ = 'which_key_ignore' },
    ['<leader>n'] = { name = '[N]eoTree', _ = 'which_key_ignore' },
    ['<leader><tab>'] = {
      name = '+tab',
    },
    -- ["<leader>c"] = {
    --   name = "+code",
    -- },
    -- ["<leader>d"] = {
    --   name = "+debug",
    -- },
    ['<leader>f'] = {
      name = '+file',
    },
    ['<leader>g'] = {
      name = '+git',
    },
    ['<leader>gb'] = {
      name = '+blame',
    },
    ['<leader>gd'] = {
      name = '+diffview',
    },
    ['<leader>h'] = {
      name = '+hunks',
    },
    -- ["<leader>n"] = {
    --   name = "+notes",
    -- },
    -- ["<leader>s"] = {
    --   name = "+search",
    -- },
    ['<leader>sn'] = {
      name = '+noice',
    },
    ['<leader>sp'] = {
      name = '+spectre',
    },
    -- ["<leader>t"] = {
    --   name = "+test",
    -- },
    ['<leader>u'] = {
      name = '+ui',
    },
    -- ["<leader>r"] = {
    --   name = "+run",
    -- },
    ['<leader>x'] = {
      name = '+diagnostics/quickfix',
    },
  }
end

return M
