return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
  },
  opts = {
    window = { position = "left", width = 35 },
    filesystem = {
      filtered_items = { visible = true },
    },
  },
}
