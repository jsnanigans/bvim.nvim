M = {}
-- U for "redo"
vim.keymap.set('n', 'U', '<C-r>', { noremap = true, silent = true, desc = 'Redo' })

local function map_normal_mode(keys, func, desc)
    -- default values:
    -- noremap: false
    -- silent: false
    vim.keymap.set("n", keys, func, { desc = desc, noremap = false, silent = true })
end

function M.setup_mini_keymaps()
    vim.keymap.set('n', '<C-b>', ':lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', { noremap = true, silent = true, desc = 'Open Files' })
end

-- file stuff
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save' })
vim.keymap.set('n', '<C-o>', ':b#<CR>', { noremap = true, silent = true, desc = 'Go to previous open buffer' })
vim.keymap.set('n', '<leader>qq', ':wqa<CR>', { noremap = true, silent = true, desc = 'Save and quit all' })


function M.setup_whichkey()
    return {
        ["<leader>q"] = {
            name = "+quick actions",
        },
        ["<leader>s"] = {
            name = "+search",
        }
    }
end

function M.setup_telescope_keymaps()
    -- git
    map_normal_mode("<leader>sc", "<cmd>Telescope git_commits<CR>", "[s]earch git [c]ommits")
    map_normal_mode("<leader>sg", "<cmd>Telescope git_status<CR>", "[s]earch git changes")

    -- searching
    map_normal_mode("<leader><leader>", require("telescope.builtin").find_files, "Find Files")
    map_normal_mode("<leader>sb", "<cmd>Telescope buffers<CR>", "[s]earch opened [b]uffers")
    map_normal_mode("<leader>sC", "<cmd>Telescope commands<cr>", "[s]earch [C]ommands")
    map_normal_mode("<leader>/", require("telescope").extensions.live_grep_args.live_grep_args, "[s]earch [g]rep")
end

function M.setup_trouble_keymaps()
  return {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xr",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  }
end

function M.setup_lsp_keymaps(event)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
  end

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

  -- Find references for the word under your cursor.
  map("gr", ':lua require("telescope.builtin").lsp_references({ show_line = false })<CR>', "[G]oto [R]eferences")

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map("<leader>cS", require("telescope.builtin").lsp_document_symbols, "Do[c]ument [S]ymbols (telescope)")

  -- Fuzzy find all the symbols in your current workspace
  --  Similar to document symbols, except searches over your whole project.
  map("<leader>cw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[w]orkspace [s]ymbols (telescope)")

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  map("K", vim.lsp.buf.hover, "Hover Documentation")

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

-- -- yank
-- vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
-- vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')
-- vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(YankyGPutAfter)')
-- vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(YankyGPutBefore)')
--
-- vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
-- vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')
--
-- local function map_normal_mode(keys, func, desc)
--   -- default values:
--   -- noremap: false
--   -- silent: false
--   vim.keymap.set('n', keys, func, { desc = desc, noremap = false, silent = true })
-- end
--
-- -- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
--
-- -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- -- is not what someone will guess without a bit more experience.
-- --
-- -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- -- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
--
-- -- TIP: Disable arrow keys in normal mode
-- -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
--
-- -- Keybinds to make split navigation easier.
-- --  Use CTRL+<hjkl> to switch between windows
-- --
-- --  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--
-- function M.setup_spectre_keymaps()
--   map_normal_mode('<leader>spt', ":lua require('spectre').toggle()<CR>", '[s][p]ectre [t]oggle')
--   map_normal_mode('<leader>spw', ":lua require('spectre').open_visual({select_word=true})<CR>", '[s][p]ectre current [w]ord')
--   map_normal_mode('<leader>spf', ':lua require("spectre").open_file_search({select_word=true})<CR>', '[s][p]ectre current [f]ile')
-- end
--
-- function M.setup_ufo_keymaps()
--   map_normal_mode('<C-f>', function()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--       -- choose one of coc.nvim and nvim lsp
--       vim.fn.CocActionAsync 'definitionHover' -- coc.nvim
--       vim.lsp.buf.hover()
--     end
--   end, 'Peek Folded Lines Under Cursor')
-- end
--
-- function M.setup_gitsigns_keymaps(bufnr)
--   local gs = package.loaded.gitsigns
--
--   vim.keymap.set('n', ']c', function()
--     if vim.wo.diff then
--       return ']c'
--     end
--     vim.schedule(function()
--       gs.next_hunk()
--     end)
--     return '<Ignore>'
--   end, { expr = true })
--
--   vim.keymap.set('n', '[c', function()
--     if vim.wo.diff then
--       return '[c'
--     end
--     vim.schedule(function()
--       gs.prev_hunk()
--     end)
--     return '<Ignore>'
--   end, { expr = true })
--
--   vim.keymap.set({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { buffer = bufnr, silent = true, noremap = true, desc = '[s]tage hunk' })
--   vim.keymap.set({ 'n', 'v' }, '<leader>hS', ':Gitsigns stage_buffer<CR>', { buffer = bufnr, silent = true, noremap = true, desc = '[S]tage buffer' })
--   vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[u]ndo stage hunk' })
--   vim.keymap.set('n', '<leader>hr', gs.reset_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[r]eset hunk' })
--   vim.keymap.set('n', '<leader>hR', gs.reset_buffer, { buffer = bufnr, silent = true, noremap = true, desc = '[R]eset buffer' })
--   vim.keymap.set('n', '<leader>hp', gs.preview_hunk, { buffer = bufnr, silent = true, noremap = true, desc = '[p]review hunk' })
--   vim.keymap.set('n', '<leader>hd', gs.diffthis, { buffer = bufnr, silent = true, noremap = true, desc = '[d]iff this' })
--
--   vim.keymap.set('n', '<leader>hD', function()
--     gs.diffthis '~'
--   end, { buffer = bufnr, silent = true, noremap = true, desc = '[D]iff this ~' })
--
--   vim.keymap.set('n', '<leader>hb', function()
--     gs.blame_line { full = true }
--   end, { buffer = bufnr, silent = true, noremap = true, desc = '[d]iff this' })
--
--   vim.keymap.set('n', '<leader>hB', gs.toggle_current_line_blame, { buffer = bufnr, silent = true, noremap = true, desc = 'Toggle line [B]lame' })
-- end
--
-- function M.setup_whichkey()
--   return {
--     ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--     ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--     ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--     ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--     ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
--     ['<leader>t'] = { name = '[T]ypeScript', _ = 'which_key_ignore' },
--     ['<leader>n'] = { name = '[N]eoTree', _ = 'which_key_ignore' },
--     ['<leader><tab>'] = {
--       name = '+tab',
--     },
--     -- ["<leader>c"] = {
--     --   name = "+code",
--     -- },
--     -- ["<leader>d"] = {
--     --   name = "+debug",
--     -- },
--     ['<leader>f'] = {
--       name = '+file',
--     },
--     ['<leader>g'] = {
--       name = '+git',
--     },
--     ['<leader>gb'] = {
--       name = '+blame',
--     },
--     ['<leader>gd'] = {
--       name = '+diffview',
--     },
--     ['<leader>h'] = {
--       name = '+hunks',
--     },
--     -- ["<leader>n"] = {
--     --   name = "+notes",
--     -- },
--     -- ["<leader>s"] = {
--     --   name = "+search",
--     -- },
--     ['<leader>sn'] = {
--       name = '+noice',
--     },
--     ['<leader>sp'] = {
--       name = '+spectre',
--     },
--     -- ["<leader>t"] = {
--     --   name = "+test",
--     -- },
--     ['<leader>u'] = {
--       name = '+ui',
--     },
--     -- ["<leader>r"] = {
--     --   name = "+run",
--     -- },
--     ['<leader>x'] = {
--       name = '+diagnostics/quickfix',
--     },
--   }
-- end
--
return M
