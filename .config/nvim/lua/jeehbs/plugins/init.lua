return {
    'hrsh7th/cmp-nvim-lua',
    {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
}
