                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          #!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[31mEste script deve ser executado como root!\e[0m"
    exit 1
fi

# Atualiza o sistema
apt update && apt upgrade -y

# Instala dependências necessárias
deps=(wget curl git)
for dep in "${deps[@]}"; do
    if ! command -v $dep &> /dev/null; then
        echo -e "\e[33mInstalando $dep...\e[0m"
        apt install -y $dep
    fi
done

# Baixa o instalador oficial do Cursor AI
CURSOR_DEB="cursor.deb"
wget -O "$CURSOR_DEB" "https://download.cursor.sh/linux_deb"

# Instala o pacote baixado
dpkg -i "$CURSOR_DEB"

# Corrige possíveis dependências pendentes
apt --fix-broken install -y

# Remove o arquivo de instalação
rm -f "$CURSOR_DEB"

# Confirma instalação
echo -e "\e[32mCursor AI foi instalado com sucesso!\e[0m"

# Executa o Cursor AI
cursor &
