return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    -- Explicitly hardcode the keymap inside Neovim
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

    require("neo-tree").setup({
      window = {
        position = "left",
        width = 35,
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    })
  end,
}

