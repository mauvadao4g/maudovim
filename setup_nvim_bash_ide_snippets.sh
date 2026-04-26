#!/bin/bash
# MAUVADAO - NVIM IDE BASH FULL + SNIPPETS
# VER: 3.0

set -e

echo "[+] Dependências..."
apt update
apt install -y curl git unzip build-essential ripgrep fd-find nodejs npm python3-pip

echo "[+] Neovim..."
cd /opt
rm -rf nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 nvim
ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

echo "[+] Estrutura..."
mkdir -p ~/.config/nvim

echo "[+] vim-plug..."
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
 https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "[+] init.vim..."

cat > ~/.config/nvim/init.vim << 'EOF'
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set termguicolors

call plug#begin('~/.config/nvim/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" LSP
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" SNIPPETS
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Tema
Plug 'folke/tokyonight.nvim'

call plug#end()

colorscheme tokyonight

lua << EOF
require('lualine').setup()
require("nvim-tree").setup()

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
}

-- LSP
require('lspconfig').bashls.setup{}

-- SNIPPETS
local luasnip = require'luasnip'

luasnip.add_snippets("sh", {
  luasnip.snippet("if", {
    luasnip.text_node({"if [ ", ""}),
    luasnip.insert_node(1, "condicao"),
    luasnip.text_node({" ]; then", "  "}),
    luasnip.insert_node(2, "comando"),
    luasnip.text_node({"", "fi"})
  }),

  luasnip.snippet("for", {
    luasnip.text_node({"for i in ", ""}),
    luasnip.insert_node(1, "lista"),
    luasnip.text_node({"; do", "  "}),
    luasnip.insert_node(2, "comando"),
    luasnip.text_node({"", "done"})
  }),

  luasnip.snippet("case", {
    luasnip.text_node({"case $1 in", ""}),
    luasnip.text_node({"  opcao)", "    "}),
    luasnip.insert_node(1, "comando"),
    luasnip.text_node({" ;;", "esac"})
  }),

  luasnip.snippet("func", {
    luasnip.text_node({"function nome() {", "  "}),
    luasnip.insert_node(1, "comando"),
    luasnip.text_node({"", "}"})
  }),

  luasnip.snippet("shebang", {
    luasnip.text_node({"#!/bin/bash"})
  }),
})

-- AUTOCOMPLETE
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  }
})
EOF

nnoremap <C-b> :NvimTreeToggle<CR>

EOF

echo "[+] LSP Bash..."
npm install -g bash-language-server

echo "[+] Lint..."
apt install -y shellcheck

echo "[+] Plugins..."
nvim +PlugInstall +qall

echo "[OK] PRONTO!"
echo "Abre com: nvim"
