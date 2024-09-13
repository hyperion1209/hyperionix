{ pkgs, ...}:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
    lunarvim;
  };

  home.file.".config/lvim/config.lua".text = ''
    -- Read the docs: https://www.lunarvim.org/docs/configuration
    -- Example configs: https://github.com/LunarVim/starter.lvim
    -- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
    -- Forum: https://www.reddit.com/r/lunarvim/
    -- Discord: https://discord.com/invite/Xb9B4Ny
    lvim.format_on_save.enabled = true
    lvim.format_on_save.pattern = { "*.py" }

    vim.opt.wrap = true
    vim.opt.foldmethod = "expr"                     -- folding set to "expr" for treesitter based folding
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding

    -- disable inline diagnostics text
    vim.diagnostic.config({ virtual_text = false })

    -- custom key mapping
    lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
    lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

    -- Language Servers
    lvim.lsp.installer.setup.automatic_installation = true

    -- Formatters
    local formatters = require "lvim.lsp.null-ls.formatters"
    formatters.setup {
      { name = "isort", filetypes = { "python" } },
      {
        name = "black",
        filetypes = { "python" },
        args = {
          "--line-length", "80" }
      },
      {
        name = "prettier",
        filetypes = { "typescript", "typescriptreact", "css", "javascript", "html", "htmldjango" },
        args = {
          "--print-with", "100" }
      },
      { name = "fixjson", filetypes = { "json" } }
    }

    -- Linters
    local linters = require "lvim.lsp.null-ls.linters"
    linters.setup {
      { name = "flake8", filetypes = { "python" } },
      { name = "hadolint", filetypes = { "dockerfile" } },
      { name = "jsonlint", filetypes = { "json" } }
    }

    -- Plugins
    lvim.plugins = {
      { "christoomey/vim-tmux-navigator" },
      -- {
      --   "AckslD/swenv.nvim",
      --   config = function ()
      --     require("swenv").setup(
      --       {
      --         get_venvs = function(venvs_path)
      --           return require('swenv.api').get_venvs(venvs_path)
      --         end,
      --         -- Path passed to `get_venvs`.
      --         venvs_path = vim.fn.expand('~/.pyenv/versions'),
      --         post_set_venv = function ()
      --           vim.cmd("LspRestart")
      --         end,
      --       }
      --     )
      --   end
      -- },
      -- { "stevearc/dressing.nvim" }
    }

    -- whichkey bindings
    -- lvim.builtin.which_key.mappings["C"] = {
    --   name = "Python",
    --   c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
    -- }

    -- Autocommands
  '';
}
