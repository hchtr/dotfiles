-- ~/dotfiles/nvim/.config/nvim/lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          -- This setting forces 'live_grep' to search hidden files
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden", -- Essential argument for finding text inside dotfiles
            "--glob=!**/.git/*", -- Keeps git history tracking hidden from cluttering searches
          },
        },
      })

      -- Adjusting keymaps to pass { hidden = true } to pickers explicitly
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files({ hidden = true }) -- Forces 'find_files' to include dotfiles
      end, { desc = "Find Files (Including Hidden)" })

      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Text (Grep)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Active Buffers" })
    end,
  }
}

