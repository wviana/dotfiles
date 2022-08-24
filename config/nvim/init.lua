-- vim: tabstop=2 shiftwidth=2 expandtab

-- Basic Config
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true

vim.g.mapleader = ' ' 

-- External Plugins
require 'paq' {
  -- Editing
  'savq/paq-nvim';
  'neovim/nvim-lspconfig';
  'nvim-treesitter/nvim-treesitter';
  'ur4ltz/surround.nvim';
  'tpope/vim-repeat';
  'b3nj5m1n/kommentary';
  'NMAC427/guess-indent.nvim';

  -- Status Line and FileExplorer
  'nvim-lualine/lualine.nvim';
  'kyazdani42/nvim-web-devicons';
  'kyazdani42/nvim-tree.lua';

  -- Telescope
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
  'nvim-telescope/telescope-ui-select.nvim';

  -- Java
  'mfussenegger/nvim-jdtls';
  'mfussenegger/nvim-dap';


  -- Theme
  -- 'sainnhe/gruvbox-material';
  { 'catppuccin/nvim'; as = 'catppuccin' };

  -- Git
  'tpope/vim-fugitive';
  'f-person/git-blame.nvim';
  'lewis6991/gitsigns.nvim';

  -- Browser Integration
  'glacambre/firenvim';

  -- CMP
  'hrsh7th/nvim-cmp';
  'hrsh7th/cmp-nvim-lsp';
  'hrsh7th/cmp-buffer';

  -- LuaSnip
  'L3MON4D3/LuaSnip';
  'saadparwaiz1/cmp_luasnip';
  'molleweide/LuaSnip-snippets.nvim';

  -- Visual Improvements
  'lukas-reineke/indent-blankline.nvim';
  'RRethy/vim-illuminate';
  'karb94/neoscroll.nvim';
}

-- Builtin Plugins
vim.cmd([[runtime ftplugin/man.vim]])


-- Plugins Setup
require'nvim-tree'.setup {}

require'surround'.setup {mappings_style = 'surround'}

require'guess-indent'.setup {}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local cmp = require'cmp'
local luasnip = require'luasnip'

luasnip.snippets = require'luasnip_snippets'.load_snippets()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'buffer' },
  })
})

cmp.setup.cmdline {
  mapping = cmp.mapping.preset.cmdline({})
}



local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<A-CR>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('v', '<A-CR>', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  require'illuminate'.on_attach(client)
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local nvim_lsp = require'lspconfig'
local servers = { 'tsserver', 'html', 'cssls', 'tailwindcss', 'gradle_ls', 'sumneko_lua', 'eslint', 'gopls', 'rust_analyzer'  }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }
end

nvim_lsp.eslint.setup{}


-- Theme Config
-- vim.g.gruvbox_material_transparent_background = 1
-- vim.cmd([[colorscheme gruvbox-material]])

vim.g.catppuccin_flavour = 'macchiato'
require'catppuccin'.setup { transparent_background = true }
vim.cmd [[colorscheme catppuccin]]


require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'catppuccin',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff',
      { 'diagnostics', sources = { 'nvim_lsp' } } },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Git Signs
require'gitsigns'.setup {}

-- Indent Line
require'indent_blankline'.setup {
  show_end_of_line = true,
  show_current_context = true,
}

-- Colorizer Config
require 'colorizer'.setup {
  'css'
}

-- Scroll
require'neoscroll'.setup {}

-- Telescope
local telescope = require'telescope'
telescope.setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

telescope.load_extension'ui-select'


-- Personal Commands
vim.cmd([[command! -nargs=1 Coauthor :read !git log | rg -i "Co-.*<args>" | head -n 1 |  sed "s/^[^C]*//"]])


-- Mappings --
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>bf', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ts', ':Telescope treesitter<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Telescope git_commits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gcl', ':Telescope git_bcommits<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>gs', ':Telescope git_stash<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rs', ':Telescope resume<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Q', '<nop>', { noremap = true, silent = true })

