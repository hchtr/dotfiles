return {
  "oxidescheme/nvim",
  name = "oxide",
  lazy = false,
  priority = 1000,
  config = function()
    require("oxide").setup({
      -- Add your custom oxide options here if you want
    })
    vim.cmd.colorscheme("oxide")
  end,
}

