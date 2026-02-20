vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.confirm = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.showtabline = 4
vim.o.winborder = 'rounded'
vim.o.clipboard = 'unnamedplus'
vim.o.shell = 'fish'
vim.o.swapfile = false
vim.o.timeoutlen = 512
vim.opt.showtabline = 0

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'rebelot/kanagawa.nvim',
    config = function()
      vim.cmd.colorscheme('kanagawa-dragon')
    end
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      local treesitter = require('nvim-treesitter')
      treesitter.setup {}
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            n = {
              ['dd'] = require('telescope.actions').delete_buffer
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescope find files.' })
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescope grep string.' })
      vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').buffers,
        { desc = 'Telescope opened buffers.' })
      vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Telescope diagnostics.' })
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Telescope Neovim help.' })
      vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Telescope keymaps.' })
      vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = 'Telescope old files.' })
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string,
        { desc = 'Telescope grep word under cursor.' })
      vim.keymap.set('n', '<leader>fm', require('telescope.builtin').man_pages, { desc = 'Telescope man pages.' })
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references,
        { desc = 'Telescope find LSP references.' })
      vim.keymap.set('n', '<leader>fn', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end, { desc = 'Telescope find Neovim config files.' })
    end,
  },
  {
    'mason-org/mason.nvim',
    opts = {}
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('groovyls', {
        cmd = { '/home/beaupreda/.local/share/nvim/mason/bin/groovy-language-server' },
        filetypes = { 'groovy' },
        root_markers = { 'Jenkinsfile', '.git' },
      })
      vim.lsp.enable({ 'lua_ls', 'ruff', 'ty', 'groovyls' })
    end
  },
  {
    'saghen/blink.cmp',
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<CR>',  { desc = 'Open diffview.' } },
      { '<leader>gc', '<cmd>DiffviewClose<CR>', { desc = 'Close diffview.' } }
    }
  }
})

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>fl', function()
  local opts = {
    formatting_options = {
      tabSize = 2,
      insertSpaces = true,
      trimTrailingWhitespace = true
    },
    async = false
  }
  vim.lsp.buf.format(opts)
end, { desc = 'For Lua buffer.' })

vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>', { desc = 'Go down in quickfix list.' })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>', { desc = 'Go up in quickfix list.' })

vim.keymap.set('n', '<leader>e', '<cmd>Oil<CR>', { desc = 'Open Oil' })

vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float()
end, { desc = 'Open float diagnostic.' })


vim.filetype.add({
  extension = {
    jenkinsfile = 'groovy',
  },
  filename = {
    ['Jenkinsfile'] = 'groovy',
    ['jenkinsfile'] = 'groovy',
  },
  pattern = {
    ['Jenkinsfile.*'] = 'groovy',
    ['jenkinsfile.*'] = 'groovy',
  },
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'bash', 'diff', 'fish', 'markdown', 'lua', 'rust', 'typst', 'c', 'cpp', 'python' },
  callback = function() vim.treesitter.start() end,
})
