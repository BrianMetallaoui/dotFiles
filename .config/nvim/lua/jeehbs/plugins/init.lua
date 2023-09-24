return {
    'hrsh7th/cmp-nvim-lua',
    'ThePrimeagen/vim-be-good',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
}
