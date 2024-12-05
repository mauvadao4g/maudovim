
" Gerenciador de plugins
call plug#begin('~/.local/share/nvim/plugged')

" Plugins
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-surround'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'             " Motor de snippets
Plug 'honza/vim-snippets'           " Coleção de snippets
Plug 'jiangmiao/auto-pairs'         " Fechamento automático de aspas e parênteses

call plug#end()

" Configuração básica
set number                      " Mostrar números das linhas
set relativenumber              " Números relativos
set tabstop=4 shiftwidth=4      " Configurar largura de tabulação
set expandtab                   " Converter tab em espaço
set cursorline                  " Destacar linha do cursor
syntax on                       " Habilitar sintaxe
filetype plugin indent on       " Indentação automática

" Configurações do NerdTree
map <C-n> :NERDTreeToggle<CR>

" Configuração do vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Configurações do vim-airline
let g:airline#extensions#tabline#enabled = 1

" Configuração do Coc (autocompletar)
let g:coc_global_extensions = ['coc-json', 'coc-python', 'coc-tsserver']

" Configuração do UltiSnips (snippets personalizados)
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
if exists("g:UltiSnipsSnippetDirectories")
    let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips']
endif

autocmd FileType sh UltiSnipsAddFiletypes sh

