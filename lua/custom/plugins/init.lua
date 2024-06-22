-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- custom/plugins/init.lua

return {
  -- LLM integration
  {
    'huggingface/llm.nvim',
    opts = {
      model = 'bigcode/starcoder',
      tokens_to_clear = { '<|endoftext|>' },
      fim = {
        enabled = true,
        prefix = '<fim_prefix>',
        middle = '<fim_middle>',
        suffix = '<fim_suffix>',
      },
      context_window = 8192,
      tokenizer = {
        repository = 'bigcode/starcoder',
      },
      -- Add any additional configuration options here
    },
  },

  -- Python test runner
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            -- Add any python-specific configurations here
            runner = 'pytest',
            python = '.venv/bin/python',
          },
        },
      }
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
  },

  -- Search and replace
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('spectre').setup()
    end,
  },

  -- Add or update LSP configuration
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      lspconfig.pyright.setup {}

      -- Key bindings for LSP functionality
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
      vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = 'Go to References' })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
    end,
  },
}
