-- ~/dotfiles/nvim/.config/nvim/lua/plugins/autopairs.lua
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- Lazy loads the plugin only when you enter Insert Mode
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Integrates with Treesitter if you use it later
        disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- Skips pairs in search menus
      })
    end,
  }
}

