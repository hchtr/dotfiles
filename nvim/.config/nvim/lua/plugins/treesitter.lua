-- ~/dotfiles/nvim/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master", -- Pinned to stable to avoid the module load crashes
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc" }, -- Automatically fetches the missing parsers
        highlight = { enable = true },
      })
    end,
  }
}

