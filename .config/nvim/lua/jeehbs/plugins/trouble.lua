return {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
 },
 config = function()
local wk = require("which-key")
wk.register({
  x = {
    name = "Trouble",
    x = { function() require("trouble").open() end, "Open" },
    w = { function() require("trouble").open("workspace_diagnostics") end, "Workspace Diago" },
    d = { function() require("trouble").open("document_diagnostics") end, "Document Diago" },
    q = { function() require("trouble").open("quickfix") end, "Quick fix" },
    l = { function() require("trouble").open("loclist") end, "Loc List" },
  },
}, { prefix = "<leader>" })
 end
}
