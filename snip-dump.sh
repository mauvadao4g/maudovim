#!/bin/bash
# CONFIGURAÇÃO DE SNIPPETS

# instalando os snippets

	# COPIANDO SH.SNIPPETS
    snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
     [[ -f "$snip" ]] && {
       # copiando o snippets pras configurações do vim
	 # cp sh.snippets "$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
       cp sh.snippets "$snip"
       [[ $? == 0 ]] && { echo "sh.snippets: configurado com sucesso"; } || {
       echo -e "\e[1;31m[❌]ERROR AO COPIAR SNIPPETS[❌]" 
       }
 
     }




	 # CONFIGURANDO HTML.SNIPPETS
    html_snip="$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/sh.snippets"
     [[ -f "$html_snip" ]] && {
       # copiando o snippets pras configurações do vim
#	 cp html.snippets "$HOME/.vim/autoload/plug/start/vim-snippets/UltiSnips/html.snippets"
        cp sh.snippets "$html_snip"
       [[ $? == 0 ]] && { echo "html.snipeets: configurado com sucesso"; } || {
       echo -e "\e[1;31m[❌]ERROR AO COPIAR SNIPPETS[❌]" 
       }
 
     }

	 echo -e "\e[1;36mConfigurações de snippets concluido.\e[0m"

