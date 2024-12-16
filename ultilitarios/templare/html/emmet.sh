#!/bin/bash

# Definindo as variáveis
EMMET_VIM_REPO="https://github.com/mattn/emmet-vim.git"
EMMET_INSTALL_PATH="$HOME/.vim/pack/plugins/start/emmet-vim"
VIMRC="$HOME/.vimrc"

# Função para exibir o menu
display_menu() {
    clear
    echo "-------------------------------------------------"
    echo "        Tutorial de Instalação do Emmet         "
    echo "-------------------------------------------------"
    echo "1. Instalar Emmet no Vim"
    echo "2. Configurar o Vim para usar Emmet"
    echo "3. Exibir tutorial Emmet"
    echo "4. Sair"
    echo "-------------------------------------------------"
    echo -n "Escolha uma opção [1-4]: "
    read option
    case $option in
        1) install_emmet ;;
        2) configure_vim ;;
        3) show_tutorial ;;
        4) exit 0 ;;
        *) echo "Opção inválida"; sleep 1; display_menu ;;
    esac
}

# Função para instalar o Emmet
install_emmet() {
    echo "Instalando o Emmet no Vim..."

    # Verifica se o diretório do Emmet já existe
    if [ -d "$EMMET_INSTALL_PATH" ]; then
        echo "Emmet já está instalado."
    else
        # Clonar o repositório do Emmet
        git clone "$EMMET_VIM_REPO" "$EMMET_INSTALL_PATH"
        echo "Emmet instalado com sucesso!"
    fi
    sleep 2
    display_menu
}

# Função para configurar o Vim para usar o Emmet
configure_vim() {
    echo "Configurando o Vim para usar o Emmet..."

    # Adiciona a configuração do Emmet no arquivo .vimrc
    if ! grep -q "emmet-vim" "$VIMRC"; then
        echo "set runtimepath+=~/.vim/pack/plugins/start/emmet-vim" >> "$VIMRC"
        echo "Configuração do Emmet adicionada ao .vimrc."
    else
        echo "Emmet já está configurado no .vimrc."
    fi
    sleep 2
    display_menu
}

# Função para exibir o tutorial
show_tutorial() {
    clear
    echo "-------------------------------------------------"
    echo "        Tutorial Completo do Emmet               "
    echo "-------------------------------------------------"
    echo ""
    echo "1. Estrutura HTML5 Básica:"
    echo "   - Com Emmet, você pode criar rapidamente a estrutura básica de um documento HTML5."
    echo "   Exemplo: html:5"
    echo "   Expande para:"
    echo "   <!DOCTYPE html>"
    echo "   <html lang='en'>"
    echo "   <head>"
    echo "       <meta charset='UTF-8'>"
    echo "       <meta name='viewport' content='width=device-width, initial-scale=1.0'>"
    echo "       <title>Document</title>"
    echo "   </head>"
    echo "   <body></body>"
    echo "   </html>"
    echo ""
    echo "2. Criar Links e Referências (href):"
    echo "   - Crie links com o comando 'a[href=\"https://exemplo.com\"]{Clique aqui}'"
    echo "   Expande para: <a href='https://exemplo.com'>Clique aqui</a>"
    echo ""
    echo "3. Criar Formulários:"
    echo "   - Crie formulários simples rapidamente."
    echo "   Exemplo: form[action='/submit' method='POST']>input[type='text' placeholder='Digite seu nome']+input[type='email' placeholder='Digite seu email']+button[type='submit']{Enviar}"
    echo "   Expande para: <form action='/submit' method='POST'>"
    echo "                      <input type='text' placeholder='Digite seu nome'>"
    echo "                      <input type='email' placeholder='Digite seu email'>"
    echo "                      <button type='submit'>Enviar</button>"
    echo "                  </form>"
    echo ""
    echo "4. Seletor de Lista Suspensa:"
    echo "   - Adicione um dropdown (lista suspensa)."
    echo "   Exemplo: select[name='opcoes']>option[value='1']{Opção 1}^option[value='2']{Opção 2}"
    echo "   Expande para: <select name='opcoes'>"
    echo "                      <option value='1'>Opção 1</option>"
    echo "                      <option value='2'>Opção 2</option>"
    echo "                  </select>"
    echo ""
    echo "5. Estruturas Complexas:"
    echo "   - Crie estruturas completas com apenas um comando."
    echo "   Exemplo: div.container>header>h1{Título}+main>p{Conteúdo}+footer>p{Rodapé}"
    echo "   Expande para: <div class='container'>"
    echo "                      <header>"
    echo "                          <h1>Título</h1>"
    echo "                      </header>"
    echo "                      <main>"
    echo "                          <p>Conteúdo</p>"
    echo "                      </main>"
    echo "                      <footer>"
    echo "                          <p>Rodapé</p>"
    echo "                      </footer>"
    echo "                  </div>"
    echo ""
    echo "6. Tabelas:"
    echo "   - Crie tabelas rapidamente."
    echo "   Exemplo: table>thead>tr>th*3+tbody>tr*2>td*3"
    echo "   Expande para: <table><thead><tr><th></th><th></th><th></th></tr></thead><tbody><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr></tbody></table>"
    echo ""
    echo "7. Campos de Upload:"
    echo "   - Adicione um campo para upload de arquivos em formulários."
    echo "   Exemplo: input[type='file']"
    echo "   Expande para: <input type='file'>"
    echo ""
    echo "8. Labels para Formulários:"
    echo "   - Inclua rótulos para os campos de formulário."
    echo "   Exemplo: label[for='nome']{Nome:}+input[type='text' id='nome' name='nome']"
    echo "   Expande para: <label for='nome'>Nome:</label><input type='text' id='nome' name='nome'>"
    echo ""
    echo "-------------------------------------------------"
    echo "Pressione qualquer tecla para voltar ao menu."
    read -n 1 -s
    display_menu
}

# Iniciar o script com o menu
display_menu
