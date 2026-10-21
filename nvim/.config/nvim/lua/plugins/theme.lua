-- ~/dotfiles/nvim/.config/nvim/lua/plugins/theme.lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Make sure it loads immediately on boot
    priority = 1000, -- Highest priority over other tools
    config = function()
      require("tokyonight").setup({
        style = "night", -- Choose between: 'storm', 'moon', 'night', or 'day'
        transparent = false, -- Set to true if you want your terminal bg to pass through
      })
      
      -- Activate the theme inside Neovim
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  }
}

