-- ~/dotfiles/nvim/.config/nvim/lua/plugins/neotree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- Adds pretty icons next to filenames
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Map Space + e to toggle the file explorer panel
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })
    end,
  }
}

