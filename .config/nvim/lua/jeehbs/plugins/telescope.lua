return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local wk = require("which-key")
            local builtin = require('telescope.builtin')

            wk.register({
                p = {
                    name = 'Project',
                    f = { "<cmd>Telescope find_files<cr>", "Find file" },
                    s = { function()
                        builtin.grep_string({ search = vim.fn.input("Grep > ") })
                    end, "Grep search" },
                },
                v = {
                    h = { "<cmd>Telescope help_tags", "Help tags Telescope" }
                }
            }, { prefix = "<leader>" })

            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        end
    },
    {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
    }
}
