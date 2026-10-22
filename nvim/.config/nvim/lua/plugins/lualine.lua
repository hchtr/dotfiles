-- ~/dotfiles/nvim/.config/nvim/lua/plugins/lualine.lua
return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox",       -- Automatically matches your active colorscheme
          icons_enabled = false, -- Keeps your preferred font, stripping graphic symbols
          
          -- Uses flat text separators instead of graphical triangle icons
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = { "mode" }, -- Displays NORMAL, INSERT, VISUAL, etc.
          
          -- 🌿 GIT INTEGRATION SECTION
          lualine_b = { 
            "branch", -- Displays the text name of your branch (e.g., "alternate")
            "diff"    -- Displays flat tracking flags like: +2 ~1 -0
          },
          
          lualine_c = { "filename" },
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" }
        }
      })
    end
  }
}

