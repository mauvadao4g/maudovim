#!/bin/bash
# MAUVADAO
# VER: 1.0.0
# copiando os snippets pra pasta do plugin
snipmate="$HOME/.vim/plugged/vim-snippets/snippets/sh.snippets"

cat <<'SNIP' > "$snipmate"
priority -50

global !p
import vim

# local: ~/.vim/pack/vendor/start/vim-snippets/UltiSnips/sh.snippets
# Tests for the existence of a variable declared by Vim's filetype detection
# suggesting the type of shell script of the current file
def testShell(scope, shell):
	return vim.eval("exists('" + scope + ":is_" + shell + "')")

# Loops over the possible variables, checking for global variables
# first since they indicate an override by the user.
def getShell():
	for scope in ["g", "b"]:
		for shell in ["bash", "posix", "sh", "kornshell"]:
			if testShell(scope, shell) == "1":
				if shell == "kornshell":
					return "ksh"
				if shell == "posix":
					return "sh"
				return shell
	return "sh"
endglobal

###########################################################################
#                            TextMate Snippets                            #
###########################################################################
snippet #! "#!/usr/bin/env (!env)" b
`!p snip.rv = '#!/usr/bin/env ' + getShell() + "\n" `


snippet shell "Cabecalho shell script"
#!/bin/bash
# MAUVADAO
# VER: 1.0.0

snippet topo "Cabecalho shell script" b
#!/bin/bash
# MAUVADAO
# VER: 1.0.0

snippet sbash "safe bash options" b
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
`!p snip.rv ='\n\n' `

snippet temp "Tempfile" b
${1:TMPFILE}="$(mktemp -t ${3:--suffix=${4:.SUFFIX}} ${2:`!p
snip.rv = re.sub(r'[^a-zA-Z]', '_', snip.fn) or "untitled"
`}.XXXXXX)"
${5:${6/(.+)/trap "/}${6:rm -f '$${1/.*\s//}'}${6/(.+)/" 0               # EXIT\n/}${7/(.+)/trap "/}${7:rm -f '$${1/.*\s//}'; exit 1}${7/(.+)/" 2       # INT\n/}${8/(.+)/trap "/}${8:rm -f '$${1/.*\s//}'; exit 1}${8/(.+)/" 1 15    # HUP TERM\n/}}

snippet /case|sw(itch)?/ "case .. esac (case)" rb
case ${1:word} in
	${2:pattern} )
		${0:${VISUAL}};;
esac


snippet elif "elif .. (elif)" b
elif ${2:[[ ${1:condition} ]]}; then
	${0:${VISUAL}}

snippet for "for ... done (for)" b
for (( i = 0; i < ${1:10}; i++ )); do
	${0:${VISUAL}}
done

snippet forin "for ... in ... done (forin)" b
for ${1:i}${2/.+/ in /}${2:words}; do
	${0:${VISUAL}}
done

snippet here "here document (here)"
<<-${2:'${1:TOKEN}'}
	$0`echo \\n`${1/['"`](.+)['"`]/$1/}

snippet /ift(est)?/ "if ... then (if)" rb
if ${2:[ ${1:condition} ]}; then
	${0:${VISUAL}}
fi


snippet if "if ... then (if)" b
if [[ ${1:condition} ]]; then
	${0:${VISUAL}}
fi


snippet until "until ... (done)" b
until ${2:[[ ${1:condition} ]]}; do
	${0:${VISUAL}}
done


snippet /wh(ile)?/ "while ... (done)" rb
while ${2:[[ ${1:condition} ]]}; do
	${0:${VISUAL}}
done


snippet func "function() {...}" b
${1:function} () {
	${0:${VISUAL}}
}


snippet iff "if inline"
# Verificando condicao
[[ ${1:condition} ]] && {
	${2:VISUAL}
}


snippet filee "Verifica se o file existe"
# verificando se o file existe
file="${1:FILE}"
[[ -f "$file" ]] && { echo 'File encontrado'; }


snippet filen "Se o file nao existe"
# Se o file nao existir faça o comando.
file="${1:FILE}"
[[ ! -f "$file" ]] && { echo'File não existe'; }


snippet status "Verifica o status da conexao"
# verificando o status da conexao
# setando informações de proxy e servidor
dom="${1:br1.forvps.xyz}"
tempo="${2:1}"
proxy="${3:timofertas.com}"
porta="${4:80}"
request="${5:PATCH}"
# fazendo o request
curl -m "$tempo" -s -o /dev/null -w '%{http_code}' -X GET "$dom" -H 'Websocket: Upgrade' -x "$proxy:$porta"



snippet ife "Verifica se o file existe"
# se for verdadeiro
[[ ${1:CONDICAO} ]] && { ${2:COMANDOS}; }


snippet ifn "Se o file nao existe"
# se nao for verdadeiro.
[[ ${1:CONDICAO} ]] && { ${2:COMANDOS}; }


snippet usada "Verificar se parâmetro está em uso" b
[[ -n "\$1" ]] && {
${1:Code}
  }


snippet check "Curl Status" b
# checa o status do host
curl -m ${1:0.60} -o /dev/null -w '%{http_code}' -X ${2:$request} "${3:\$dom}" -H "Websocket: Upgrade" -x "${4:$proxy}:${4:$porta}"



snippet tutorial "Função tutorial com verificação" b
# tutorial
TUTORIAL(){
   cat <<'TUTO' 
${1:TEXTO_TUTORIAL}

TUTO

}
# verifica se foi chamada a função tutorial
if [[ "\$1" == *'code'* || "\$1" == *'h'* ]]; then
    TUTORIAL
    exit 0
fi


snippet chk "Curl Status"
# Checar o status do host
curl -m1 -o /dev/null -w '%{http_code}' -X ${1:$request} "${2:\$dom}" -H "Websocket: Upgrade" -x "${3:$proxy}:${4:$port}"






snippet vazio "Verificar se parâmetro está vazio" b
[[ -z "\$1" ]] && { echo "Uso: \$0 <parametros>"; exit 0; }





# checando se a aplicação ja está instalada
snippet install "Check Command Exists" b
if ! command -v ${1:command} &>/dev/null; then
    echo "${1:command} could not be found"
    exit 1
fi


# cria uma pasta temporaria
snippet tmpfile "Temporary File" b
TMPFILE=$(mktemp)
${1:## code}
rm -f "$TMPFILE"


# lendo linhas de files.txt
snippet readfile "Read File Line by Line" b
while IFS= read -r line; do
    echo "\$line"
	${1:COMANDOS}
done < "${2:filename}"


# conectando ao ssh
snippet ssh "SSH Command" b
ssh ${1:root}@${2:host} -p ${3:22}


# conectando ao servidor sem nescecidade de colocar senhas.
snippet sshpass "SSH usando senha"
servidor="${1:servidor}"
user="${2:root}"
pass="${3:pass}"
porta="${4:22}"
sshpass -p "$pass" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=2 "$user@$servidor" -p $porta




# colorindo mensagens
snippet paleta "Cria uma funçao contendo todas as cores"
# FUNÇÃO PRA COLORIR AS MENSAGEM DO ECHO
msg_cor(){
case "\$1" in
vm|vermelho)
echo -e "\e[1;31m\$2\e[m"
;;
vd|verde)
echo -e "\e[1;32m\$2\e[m"
;;
bd|bordo)
echo -e "\e[1;35m\$2\e[m"
;;
am|amarelo)
echo -e "\e[1;33m\$2\e[m"
;;
cy|cyano)
echo -e "\e[1;36m\$2\e[m"
;;
az|azul)
echo -e "\e[1;34m\$2\e[m"
;;
*)
echo -e "\e[1;37m\$2\e[m"
esac
}
# pra chamar a função exibindo as cores
# msg_cor 'cyano' "$saudacao. Agora são $hora:$minuto"




# Adicionando função de horario
snippet horas "Obten o horario atual com saudação."
_horas(){
# Obtém a hora atual no fuso horário de São Paulo
hora=$(TZ=America/Sao_Paulo date +%H)
minuto=$(TZ=America/Sao_Paulo date +%M)

# Define as saudações com base no horário
if [ "$hora" -ge 0 -a "$hora" -lt 12 ]; then
    saudacao="Bom Dia"
elif [ "$hora" -ge 12 -a "$hora" -lt 18 ]; then
    saudacao="Boa Tarde"
else
    saudacao="Boa Noite"
fi
}


# PEGANDO INFORMAÇÕES DO VIDEO URL
snippet ytinf "Pegando informações do url do video"
# Pegando informações do video
# Gerar variáveis a partir do JSON recebido

videoInfo() {
        video_url="${1:$1}"
        response=$(yt-dlp --cookies "$cookies" \
        --user-agent "$agente" \
        -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]/bestvideo[ext=mp4]' \
        "$video_url" --print-json --no-warning  --skip-download 2>/dev/null)

    nomeVideo="$(echo "$response" | jq -r '.title')"
    urlVideo="$(echo "$response" | jq -r '.webpage_url')"
    duracaoVideo="$(echo "$response" | jq -r '.duration')"
    duracao="$(echo "$response" | jq -r '.duration_string')"
    dataVideo="$(echo "$response" | jq -r '.upload_date')"
    viewsVideo="$(echo "$response" | jq -r '.view_count')"
    idCanal="$(echo "$response" | jq -r '.uploader_id')"
    canalVideo="$(echo "$response" | jq -r '.uploader_url')"
    resolucao="$(echo "$response" | jq -r '.resolution')"
    postado="$dataVideo"
  #  _passado="$(calcular_tempo_passado "$postado")"


 # Exibir os dados
 cat <<EOF
Nome: $nomeVideo
Url: $urlVideo
Duração: $duracao
Postado: $_passado
Views: $viewsVideo
Resolução: $resolucao
Canal: $idCanal
UrlCanal: $canalVideo
EOF
}



# BAIXAR VIDEO DA URL
snippet ytdown "Download de video url"
ytdown(){
	# baixando videos da url.
cookies="${1:cookies.txt}"
video_url="${2:\$1}"
yt-dlp --cookies "$cookies" \
        --user-agent "$agente" \
        -f 'bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]/bestvideo[ext=mp4]' \
        "$video_url" 2>/dev/null

}



snippet echo "Printa a mensagem na tela"
echo -e "\e[1;${1:37}m${2:$MENSAGEM}\e[0m"



snippet echsz "Printa a mensagem na tela na cor sinza"
echo -e "\e[1;${1:30}m${2$MENSAGEM}\e[0m"


snippet echvm "Printa a mensagem na cor vermelho"
echo -e "\e[1;${1:31}m${2$MENSAGEM}\e[0m"


snippet echvd "Printa a mensagem na cor verde"
echo -e "\e[1;${1:32}m${2$MENSAGEM}\e[0m"


snippet echam "Printa a mensagem na cor amarelo"
echo -e "\e[1;${1:33}m${2$MENSAGEM}\e[0m"


snippet echaz "Printa a mensagem na cor azul"
echo -e "\e[1;${1:34}m${2$MENSAGEM}\e[0m"


snippet echbd "Printa a mensagem na cor bordo"
echo -e "\e[1;${1:35}m${2$MENSAGEM}\e[0m"


snippet echcy "Printa a mensagem na cor cyano"
echo -e "\e[1;${1:36}m${2$MENSAGEM}\e[0m"


snippet echbr "Printa a mensagem na cor branco"
echo -e "\e[1;${1:37}m${2$MENSAGEM}\e[0m"


snippet bkp "Gera o nome do file de backup"
# Gerando um file de backup
file="$( echo ${1:file-}$(date '+%d%m%y_%H%M%S').bkp)"
${2:COMANDOS PRA EXEXUTAR}
[[ -f "$file" ]] && { echo "File criado com sucesso: $file"; }



####################################################
#             TELEGRAM MENSAGENS
####################################################

####################################################
#   VISUALIZAÇÕES DE MENSAGENS
####################################################
# Snippet para obter as atualizações pendentes
snippet getupdates "Obtém atualizações pendentes"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates"


# Snippet para obter atualizações com offset (evitar duplicidade)
snippet getupdatesoffset "Obtém atualizações usando offset"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" \
-d offset="${2:OFFSET}" \
-d limit="${3:100}" \
-d timeout="${4:0}"


# Snippet para extrair o chat_id de uma atualização
snippet getchatid "Extrai o chat_id de uma atualização"
echo "$(curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | jq '.result[0].message.chat.id')"


# Snippet para extrair o texto da mensagem de uma atualização
snippet getmsg "Extrai o texto da mensagem"
echo "$(curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | jq -r '.result[0].message.text')"


# Snippet para processar mensagens com loop
snippet processupdates "Processa mensagens recebidas com loop"
while true; do
  updates=$(curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" -d offset="${2:OFFSET}" -d timeout=10)
  echo "$updates" | jq -c '.result[]' | while read -r message; do
    chat_id=$(echo "$message" | jq -r '.message.chat.id')
    user_message=$(echo "$message" | jq -r '.message.text')
    # Aqui você pode adicionar o código para responder ou processar a mensagem
    echo "Mensagem recebida de $chat_id: $user_message"
    # Atualiza o offset para evitar processar a mesma mensagem novamente
    OFFSET=$(echo "$message" | jq '.update_id') && OFFSET=$((OFFSET+1))
  done
done


# Snippet para capturar mensagens enviadas em grupos
snippet groupmsgs "Filtra mensagens enviadas em grupos"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[] | select(.message.chat.type == "group") | .message'


# Snippet para capturar mensagens de usuários específicos
snippet usermsgs "Filtra mensagens de um usuário específico"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[] | select(.message.from.id == ${2:USER_ID}) | .message.text'


# Snippet para capturar mensagens com entidades (ex.: comandos ou links)
snippet commandmsgs "Filtra mensagens com entidades"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[] | select(.message.entities != null) | .message'


# Snippet para capturar informações do usuário que enviou uma mensagem
snippet getuserinfo "Extrai informações do usuário"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[0].message.from | {id, is_bot, first_name, username}'


# Snippet para obter mensagens com fotos anexadas
snippet photomsgs "Filtra mensagens com fotos"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[] | select(.message.photo != null) | .message'


# Snippet para obter mensagens com localização
snippet locmsgs "Filtra mensagens com localização"
curl -s "https://api.telegram.org/bot${1:$TOKEN}/getUpdates" | \
jq -r '.result[] | select(.message.location != null) | .message.location'

####################################################
#         ENVIO DE MENSAGEMS
####################################################


snippet testt "apenas um teste"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendMessage" -d chat_id="${2:$CHAT_ID}" -d text="${3:$MENSAGEM}" -d parse_mode="${4:HTML}"


# Snippet para enviar uma mensagem de texto simples
snippet sendmsg "Envia uma mensagem de texto"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendMessage" -d chat_id="${2:$CHAT_ID}" -d text="${3:$MENSAGEM}" -d parse_mode="${4:HTML}"


# Snippet para enviar uma foto
snippet sendphoto "Envia uma foto com descrição"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendPhoto" -F chat_id="${2:$CHAT_ID}" -F photo="@${3:CAMINHO/DA/FOTO}" -F caption="${4:$DESCRICAO}" -F parse_mode="${5:HTML}"


# Snippet para enviar um documento
snippet senddoc "Envia um documento com descrição"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendDocument" -F chat_id="${2:$CHAT_ID}" -F document="@${3:CAMINHO/DO/ARQUIVO}" -F caption="${4:$DESCRICAO}" -F parse_mode="${5:HTML}"


# Snippet para enviar uma mensagem com teclado inline
snippet sendinline "Envia uma mensagem com botões inline"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendMessage" \
-d chat_id="${2:$CHAT_ID}" \
-d text="${3:$MENSAGEM}" \
-d parse_mode="${4:HTML}" \
-d reply_markup='{"inline_keyboard": [[{"text": "${5:NOME_DO_BOTÃO}", "url": "${6:URL_DO_BOTÃO}"}]]}'


# Snippet para enviar mensagem com teclado customizado
snippet sendkeyb "Envia mensagem com teclado customizado"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendMessage" \
-d chat_id="${2:$CHAT_ID}" \
-d text="${3:$MENSAGEM}" \
-d parse_mode="${4:HTML}" \
-d reply_markup='{"keyboard": [["${5:BOTÃO1}"], ["${6:BOTÃO2}"]], "resize_keyboard": true, "one_time_keyboard": true}'


# Snippet para editar mensagem de texto
snippet editmsg "Edita uma mensagem de texto enviada anteriormente"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/editMessageText" \
-d chat_id="${2:$CHAT_ID}" \
-d message_id="${3:$MESSAGE_ID}" \
-d text="${4:NOVA_MENSAGEM}" \
-d parse_mode="${5:HTML}"


# Snippet para deletar mensagem
snippet delmsg "Deleta uma mensagem enviada"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/deleteMessage" \
-d chat_id="${2:$CHAT_ID}" \
-d message_id="${3:$MESSAGE_ID}"


####################################################
#  FUNÇÕES TELEGRAM PARTE 2 (ADICIONAIS)
####################################################
# Snippet para enviar uma mensagem de localização
snippet sendloc "Envia uma localização"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendLocation" \
-d chat_id="${2:$CHAT_ID}" \
-d latitude="${3:LATITUDE}" \
-d longitude="${4:LONGITUDE}" \
-d horizontal_accuracy="${5:HORIZONTAL_ACCURACY}"


# Snippet para enviar um áudio
snippet sendaudio "Envia um arquivo de áudio com legenda"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendAudio" \
-F chat_id="${2:$CHAT_ID}" \
-F audio="@${3:CAMINHO/DO/AUDIO}" \
-F caption="${4:$DESCRICAO}" \
-F parse_mode="${5:HTML}" \
-F performer="${6:ARTISTA}" \
-F title="${7:TÍTULO}"


# Snippet para enviar um vídeo
snippet sendvideo "Envia um vídeo com legenda"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendVideo" \
-F chat_id="${2:$CHAT_ID}" \
-F video="@${3:CAMINHO/DO/VIDEO}" \
-F caption="${4:$DESCRICAO}" \
-F parse_mode="${5:HTML}" \
-F supports_streaming="${6:true}"


# Snippet para enviar uma mensagem de contato
snippet sendcontact "Envia um contato"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendContact" \
-d chat_id="${2:$CHAT_ID}" \
-d phone_number="${3:NUMERO_DO_TELEFONE}" \
-d first_name="${4:PRIMEIRO_NOME}" \
-d last_name="${5:ULTIMO_NOME}"


# Snippet para enviar uma enquete
snippet sendpoll "Envia uma enquete para o usuário"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendPoll" \
-d chat_id="${2:$CHAT_ID}" \
-d question="${3:PERGUNTA}" \
-d options='["${4:OPCAO1}", "${5:OPCAO2}"]' \
-d is_anonymous="${6:true}"


# Snippet para encaminhar uma mensagem
snippet forwardmsg "Encaminha uma mensagem"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/forwardMessage" \
-d chat_id="${2:$CHAT_ID_DESTINO}" \
-d from_chat_id="${3:$CHAT_ID_ORIGEM}" \
-d message_id="${4:$MESSAGE_ID}"


# Snippet para enviar uma animação (GIF)
snippet sendanimation "Envia uma animação (GIF)"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendAnimation" \
-F chat_id="${2:$CHAT_ID}" \
-F animation="@${3:CAMINHO/DO/ARQUIVO}" \
-F caption="${4:$DESCRICAO}" \
-F parse_mode="${5:HTML}"


# Snippet para enviar uma ação de digitação
snippet sendaction "Envia uma ação de digitação ou carregamento"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/sendChatAction" \
-d chat_id="${2:$CHAT_ID}" \
-d action="${3:typing}" # Opções: typing, upload_photo, record_video, upload_video, record_voice, upload_voice, upload_document, find_location, record_video_note, upload_video_note


# Snippet para fixar uma mensagem em um chat
snippet pinmsg "Fixa uma mensagem em um chat"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/pinChatMessage" \
-d chat_id="${2:$CHAT_ID}" \
-d message_id="${3:$MESSAGE_ID}" \
-d disable_notification="${4:false}"


# Snippet para desfixar uma mensagem em um chat
snippet unpinmsg "Desfixa uma mensagem em um chat"
curl -s -X POST "https://api.telegram.org/bot${1:$TOKEN}/unpinChatMessage" \
-d chat_id="${2:$CHAT_ID}" \
-d message_id="${3:$MESSAGE_ID}"

####################################################


####################################################
#      SNIPEETS UTEIS AO DIA A DIA
####################################################
###########################################################
#      SNIPEETS PEGANDO INFORMAÇÕES DE IP EXTERNO E INTERNO
###########################################################

# Snippet para obter o IP externo do provedor
snippet ipex "Verifica o ip externo da máquina"
# Utiliza um serviço público para obter o IP externo da máquina
IP_EXTERNO="$(curl -s https://api64.ipify.org || curl -s https://api.ipify.org)
echo -e "\e[1;32mIP:\e[0m \e[1;33m$IP_EXTERNO\e[0m"


# Snippet para obter o IP interno da máquina
snippet ipin "Verifica o ip interno da máquina"
# Exibe o IP interno atribuído à interface de rede ativa
IP_INTERNO=$(ip addr show | awk '/inet / {print $2}' | cut -d/ -f1 | grep -v "127.0.0.1")
echo -e "\e[1;32mIP:\e[0m \e[1;33m$IP_INTERNO\e[0m"


snippet ipex_dig "Verifica o IP externo usando dig"
# Obtém o IP externo consultando servidores de DNS do Google
dig +short myip.opendns.com @resolver1.opendns.com


snippet ipex_wget "Verifica o IP externo usando wget"
# Utiliza wget para consultar o IP externo
wget -qO- https://api64.ipify.org || wget -qO- https://api.ipify.org


snippet ipex_http "Verifica o IP externo usando httpie"
# Usa o httpie para consultar o IP externo
http https://api64.ipify.org


snippet ipex_nslookup "Verifica o IP externo usando nslookup"
# Resolve o IP externo consultando o serviço opendns
nslookup myip.opendns.com resolver1.opendns.com | awk '/Address/ {print $2}' | tail -n1


snippet ipin_hostname "Verifica o IP interno usando hostname"
# Mostra todos os IPs internos associados à máquina
hostname -I | awk '{print $1}'


snippet ipin_ifconfig "Verifica o IP interno usando ifconfig"
# Obtém o IP interno utilizando o ifconfig
ifconfig | grep "inet " | awk '{print $2}' | grep -v "127.0.0.1"


snippet ipin_nmcli "Verifica o IP interno usando nmcli"
# Exibe o IP interno associado à conexão ativa do NetworkManager
nmcli -g IP4.ADDRESS device show | grep -v "127.0.0.1"


snippet ipin_simple "Verifica o IP interno usando ip e grep"
# Mostra o IP interno da interface ativa
ip -4 -o addr show | grep -v "127.0.0.1" | awk '{print $4}' | cut -d/ -f1


snippet ipin_python "Verifica o IP interno usando Python"
# Obtem o IP interno utilizando Python
python3 -c "import socket; print(socket.gethostbyname(socket.gethostname()))"



####################################################
#
####################################################
# VERIFICAR URL
snippet check_url "Verifica se a URL é um domínio ou um IPv4 válido"
# Função para verificar se é um IPv4 válido
is_ipv4() {
  local ip=\$1
  [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] && \
  for octet in $(echo "$ip" | tr '.' ' '); do
    [[ $octet -ge 0 && $octet -le 255 ]] || return 1
  done && return 0 || return 1
}

# Função para verificar se é um domínio válido
is_domain() {
  local domain=\$1
  [[ $domain =~ ^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z]{2,})+$ ]]
}

# Verificar entrada
check_url() {
  local input=\$1
  if is_ipv4 "$input"; then
    echo "É um IPv4 válido."
  elif is_domain "$input"; then
    echo "É um domínio válido."
  else
    echo "Entrada inválida."
  fi
}




####################################################
#  BAIXANDO CONFIGURAÇÕES DO APLICATIVO C4G
####################################################
# busca por nome na configuração Networks.
snippet c4g_name "Busca em JSON de uma URL por redes com nome correspondente usando --arg"
# Busca por nome na chave .Networks fintrando pelo campo .Name
# Define a URL e o termo de busca
url="\$1"
search="\$2"

# Faz a requisição à URL e utiliza jq para filtrar as redes com base no termo, usando --arg para passar variáveis
curl -sL "$url" | jq --arg search "$search" '.Networks[] | select(.Name | test($search;"i"))'


# busca por Payloads.
snippet c4g_payloads "Busca em JSON de uma URL por redes com nome correspondente usando --arg"
# busca por Payloads.
# Define a URL e o termo de busca
url="\$1"
# Faz a requisição à URL e utiliza jq para filtrar as redes com base no termo, usando --arg para passar variáveis
curl -sL "$url" | jq '.Networks[] | .Payload' | sed 's/"/\n"/'




# Busca por Proxy
snippet c4g_proxy "Busca em JSON de uma URL por redes com nome correspondente usando --arg"
# Define a URL e o termo de busca
url="\$1"
curl -sL "$url" | jq '.Networks[] | .ProxyIP'




# Busca por UrlUpdate
snippet c4g_urlupdate "Busca em JSON de uma URL por redes com nome correspondente usando --arg"
# Define a URL e o termo de busca
url="\$1"
curl -sL "$url" | jq '.UrlUpdate'



# Busca por Sni
snippet c4g_sni "Busca em JSON de uma url por .SNI"
# Define a URL e o termo de busca
url="\$1"
curl -sL "$url" | jq '.Networks[] | .SNI'




# Busca por .Networks
snippet c4g_networks "Busca em JSON de uma url por .Networks"
# Define a URL e o termo de busca
url="\$1"
curl -sL "$url" | jq '.Networks[]'




####################################################
#    DATA E HORAS
####################################################
snippet data "Visualizar data"
data=$(date '+%Y-%m-%d %H:%M:%S')
echo "$data"


snippet hr "Visualizar o horario"
horas=$(date '+%H:%M:%S')
echo "$horas"


# verificar se programa existe
snippet command "Visualizar se o programa esta instalado"
# Verificação de dependências
if ! command -v ${1:APLICAÇÃO} &> /dev/null; then
    log "Erro: $1 não está instalado."
    exit 1
fi



snippet dire "Verificar se o diretório de origem existe"

# Verificar se o diretório de origem existe
if [[ ! -d "${1:$SOURCE_DIR}" ]]; then
    log "Erro: Diretório de origem ${1:$SOURCE_DIR} não existe."
    exit 1
fi


snippet $? "Verificar o status do comando"
# Verificar o status do backup
if [ $? -eq 0 ]; then
    echo -e "\e[1;32m${1:Sucesso}\e[0m"
else
    echo -e "\e[1;31m${2:Error}\e[0m"
    exit 1
fi



snippet log "Cria um log"
# Função de log
log() {
    local message="\$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}



snippet diren "Verificar se o diretorio existe , caso nao ele cria um novo diretorio"
# Verificar se o diretório de destino existe, cria se necessário
if [ ! -d "$DESTINATION_DIR" ]; then
    log "Diretório de destino $DESTINATION_DIR não encontrado. Criando..."
    mkdir -p "$DESTINATION_DIR"
    if [ $? -ne 0 ]; then
        log "Erro: Falha ao criar o diretório de destino."
        exit 1
    fi
fi


snippet tempfun "Cria um arquivo tempoario"
criar_temp() {
    local tipo="$1"   # "arquivo" ou "diretorio"
    local prefixo="$2" # Prefixo opcional
    local temp

    if [[ "$tipo" == "diretorio" ]]; then
        temp=$(mktemp -d "${prefixo:-/tmp/tempdir.XXXXXX}")
        echo "Diretório temporário criado: $temp"
    elif [[ "$tipo" == "arquivo" ]]; then
        temp=$(mktemp "${prefixo:-/tmp/tempfile.XXXXXX}")
        echo "Arquivo temporário criado: $temp"
    else
        echo "Uso: criar_temp <tipo> [prefixo]"
        echo "  tipo: 'arquivo' ou 'diretorio'"
        echo "  prefixo: (opcional) Exemplo: /tmp/meu_arquivo.XXXXXX"
        return 1
    fi

    echo "$temp"
}


snippet tempdir
 temp=$(mktemp -d "${1:~/tmp/tempdir.XXXXXX}")



snippet tempfile
 temp=$(mktemp "${1:~/tmp/tempdir.XXXXXX}")



snippet /fex?/ "if file exists" rb
if [[ -e ${1:filename} ]]; then
    echo "O arquivo '${1:filename}' existe."
else
    echo "O arquivo '${1:filename}' não existe."
fi




####################################################
# vim:ft=snippets:
SNIP


echo "Snippets configurado"
