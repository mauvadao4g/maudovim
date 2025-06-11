#!/data/data/com.termux/files/usr/bin/bash

echo "[+] Iniciando instalação do Vim personalizado no Termux..."

# Atualiza pacotes
pkg update -y && pkg upgrade -y

# Instala dependências se necessário
for pkg in vim git curl; do
    if ! command -v $pkg &> /dev/null; then
        echo "[*] Instalando dependência: $pkg"
        pkg install -y $pkg
    fi
done

# Instala o vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "[*] Instalando vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Cria ~/.vimrc com plugins
cat > ~/.vimrc << 'EOF'
" --- VIMRC GERADO PELA EMILY ---
silent! call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-emoji'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'dracula/vim'
Plug 'sainnhe/sonokai'

call plug#end()

set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
syntax on
set background=dark
colorscheme sonokai

" NerdTree toggle
nnoremap <C-n> :NERDTreeToggle<CR>
EOF

# Instala os plugins
echo "[*] Instalando plugins com vim-plug..."
vim +PlugInstall +qall

echo "[✔] Instalação finalizada. Abra o Vim e teste."


cat <<EOF

🧪 Como rodar

chmod +x lite_vim_install.sh
./lite_vim_install.sh

EOF
