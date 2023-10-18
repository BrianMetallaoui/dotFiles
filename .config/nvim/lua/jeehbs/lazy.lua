local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

local kind_icons = {
    Text = "󰉿",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = " ",
    Variable = "󰀫",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "󰑭",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = " ",
    Misc = " "
}

require("lazy").setup("jeehbs.plugins")
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({
        buffer = bufnr
    })

    local cmp = require('cmp')
    local cmp_action = require('lsp-zero').cmp_action()
    local cmp_select = {
        behavior = cmp.SelectBehavior.Select
    }

    cmp.setup({
        preselect = 'item',
        completion = {
            completeopt = 'menu,menuone,noinsert'
        },
        sources = {{
            name = 'nvim_lsp'
        }, {
            name = 'buffer'
        }, {
            name = "crates"
        }, {
            name = 'nvim_lua'
        }},
        formatting = {
            fields = {"kind", "abbr", "menu"},
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]"
                })[entry.source.name]
                return vim_item
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-f>'] = cmp_action.luasnip_jump_forward(cmp_select),
            ['<C-b>'] = cmp_action.luasnip_jump_backward(cmp_select),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm({
                select = true
            })
        })
    })
end)

lsp_zero.setup_servers({'rust_analyzer', 'dartls', 'lua_ls'})

lsp_zero.format_on_save({
    format_opts = {
        async = false,
        timeout_ms = 10000
    },
    servers = {
        ['rust_analyzer'] = {'rust'},
        ['dartls'] = {'dart'},
        ['lua_ls'] = {'lua'}
    }
})

require('flutter-tools').setup({
    lsp = {
        capabilities = lsp_zero.get_capabilities()
    },
    debugger = {
        enabled = true,
        register_configurations = function(_)

            local dap = require('dap')

            if vim.loop.os_uname().sysname == "Windows_NT" then
                local flutterBin = vim.fn.resolve(vim.fn.exepath('flutter.bat'))
                local flutterSdk = vim.fn.fnamemodify(flutterBin, ":h:h")
                local dartSdk = flutterSdk .. '\\bin\\cache\\dart-sdk'

                dap.adapters.dart = {
                    type = 'executable',
                    command = vim.fn.exepath('cmd.exe'),
                    args = {'/c', flutterBin, 'debug_adapter'},
                    options = {
                        detached = false
                    }
                }
                dap.configurations.dart = {{
                    type = 'dart',
                    request = 'launch',
                    name = "Launch Flutter",
                    dartSdkPath = dartSdk,
                    flutterSdkPath = flutterSdk,
                    program = "${workspaceFolder}\\lib\\main.dart",
                    cwd = '${workspaceFolder}',
                    toolArgs = {'-d', 'windows'},
                    sendLogsToClient = true
                }}
            else
                -- Dart / Flutter

                dap.adapters.flutter = {
                    type = 'executable',
                    command = vim.fn.stdpath('data') .. '/mason/bin/dart-debug-adapter',
                    args = {'flutter'}
                }
                dap.configurations.dart = {{
                    type = "flutter",
                    request = "launch",
                    name = "Launch flutter",
                    dartSdkPath = "/home/jeehbs/.local/bin/flutter/bin/cache/dart-sdk/", -- ensure this is correct
                    flutterSdkPath = "/home/jeehbs/.local/bin/flutter", -- ensure this is correct
                    program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
                    cwd = "${workspaceFolder}"
                }}
            end

        end
    }
})
require("mason").setup()

