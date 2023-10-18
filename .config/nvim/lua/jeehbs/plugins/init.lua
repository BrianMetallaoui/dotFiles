return { 'hrsh7th/cmp-nvim-lua', 'ThePrimeagen/vim-be-good', 'mfussenegger/nvim-dap', 'mfussenegger/nvim-dap',
    'williamboman/mason.nvim', {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}, {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' }
} }
