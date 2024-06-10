return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        dependencies = {
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = { 'neovim/nvim-lspconfig' },
            },
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local servers = {
                'lua_ls',
                'tsserver',
                'eslint',
                'typos_lsp',
                'astro',
            }

            local function organize_imports()
                local params = {
                    command = '_typescript.organizeImports',
                    arguments = { vim.api.nvim_buf_get_name(0) },
                    title = '',
                }
                vim.lsp.buf.execute_command(params)
            end

            require('mason').setup()
            require('mason-lspconfig').setup {
                ensure_installed = servers,
            }

            local lspconfig = require 'lspconfig'

            local onAttach = {
                eslint = function(client, bufnr)
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        buffer = bufnr,
                        command = 'EslintFixAll',
                    })
                end,
            }
            local commands = {
                tsserver = {
                    OrganizeImports = {
                        organize_imports,
                        description = 'Organize Imports',
                    },
                },
            }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    on_attach = function(client, bufnr)
                        local oa = onAttach[lsp]
                        if oa then
                            oa(client, bufnr)
                        end
                    end,
                    capabilities = capabilities,
                    commands = commands[lsp],
                }
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach-keymaps', { clear = true }),
                callback = function(event)
                    require('config.keymaps').setup_lsp_keymaps(event)
                end,
            })
        end,
    },
    {
        'j-hui/fidget.nvim',
        opts = {
            -- options
        },
    },
}
