#!/bin/bash
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/list > /dev/null 2>&1
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/versao -O /bin/versao > /dev/null 2>&1
wget https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Install/licence -O /usr/lib/licence > /dev/null 2>&1
clear
[[ "$EUID" -ne 0 ]] && echo -e "\033[1;33mDesculpe, \033[1;33mvocê precisa executar como root\033[0m" && rm -rf $HOME/Plus > /dev/null 2>&1 && return 1
cd $HOME
fun_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m#"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "  \033[1;33mAGUARDE \033[1;37m- \033[1;33m["
done
echo -e "\033[1;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
tput cnorm
}
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "BEM VINDO AO SSHPLUS MANAGER" ; tput sgr0
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo ""
echo -e "             \033[1;31mATENCAO! \033[1;33mESSE SCRIPT IRA...\033[0m"
echo ""
echo -e "\033[1;31m● \033[1;33mAtivar Proxy Squid nas portas 80, 8080 e 8799 \033[0m"
echo -e "\033[1;31m● \033[1;33mConfigurar OpenSSH para rodar nas portas 22, 443 \033[0m"
echo -e "\033[1;31m● \033[1;33mInstalar um conjunto de scripts como comandos do \033[0m" 
echo -e "\033[1;33msistema para o gerenciamento de usuários..\033[0m"
echo ""
echo -e "\033[1;32mDICA! \033[1;33mUsuarios do JUICESSH selecione o tema Dark\033[0m"
echo -e "\033[1;33mnas configuracoes do aplicativo, para uma melhor\033[0m"
echo -e "\033[1;33mvisualizacao...\033[0m"
echo ""
echo -e "\033[1;31m≠×≠×≠×≠×≠×≠×≠×≠×[\033[1;33m • \033[1;32mSSHPLUS MANAGER FREE\033[1;33m •\033[1;31m ]≠×≠×≠×≠×≠×≠×≠×≠×\033[0m"
echo ""
echo -ne "\033[1;36mGenerar As Key [N/S]:\033[1;37m "; read key
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -ne "\033[1;36mAGUARDE... \033[1;32m OK !\033[1;37m "
chmod +x list ./list > /dev/null 2>&1
echo ""
echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;36mVerificando a key\033[1;35m ...\033[0m"
sleep 2
echo ""
echo -ne "\033[1;36mInforme seu Nome:\033[1;37m "; read name
if [ -z "$name" ]; then
  echo ""
  echo -e "\033[1;31mErro \033[1;32mNome vazio!\033[0m"
  rm -rf $HOME/Plus $_lsk/list > /dev/null 2>&1
  sleep 2
  clear; exit 1
fi
IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$IP" = "" ]]; then
  IP=$(wget -qO- ipv4.icanhazip.com)
fi
echo ""
echo -ne "\033[1;36mPara continuar confirme seu IP \033[1;37m"; read -e -i $IP ipdovps
if [ -z "$ipdovps" ]; then
  echo ""
  echo -e "\033[1;31mErro \033[1;32mIP incorreto!\033[0m"
  rm -rf $HOME/Plus $_lsk/list > /dev/null 2>&1
  sleep 2
  clear; exit 1
fi
if [ -f "$HOME/usuarios.db" ]
then
    clear
    echo ""
    echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
    echo -e "                 \033[1;33m● \033[1;31mATENCAO \033[1;33m●\033[0m"
    echo ""
    echo -e "\033[1;33mUma base de Dados de Usuários \033[1;32m(usuarios.db) \033[1;33mFoi" 
    echo -e "Encontrada! Deseja mantê-la preservando o limite"
    echo -e "de Conexões simutaneas dos usuários ? Ou Deseja"
    echo -e "criar uma nova base de dados ?\033[0m"
    echo ""
    echo -e "\033[1;33m[\033[1;31m1\033[;33m] Manter Base de Dados Atual\033[0m"
    echo -e "\033[1;33m[\033[1;31m2\033[1;33m] Criar uma Nova Base de Dados\033[0m"
    echo ""
    echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
    echo ""
    tput setaf 2 ; tput bold ; read -p "Opção ?: " -e -i 1 optiondb ; tput sgr0
else
    awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
fi
echo ""
clear
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-18s\n' " AGUARDE A INSTALAÇÃO" ; tput sgr0
echo ""
echo ""
echo -e "           \033[1;33m● \033[1;32mAtualizando Sistema \033[1;33m●\033[0m"
echo ""
echo -e "    \033[1;33mAtualizações costuma demorar um pouco!\033[0m"
echo ""
fun_attlist () {
    apt-get update -y
    if service apache2 status; then
    service apache2 stop
    else
    apt-get remove apache2 -y
    fi
}
fun_bar 'fun_attlist'
sleep 1
clear
echo ""
echo -e "           \033[1;33m● \033[1;32mInstalando Pacotes \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;33mAlguns pacotes são extremamente nessecarios!\033[0m"
echo ""
inst_pct () {
apt-get install squid3 bc screen nano unzip dos2unix -y > /dev/null 2>&1
apt-get install nload -y > /dev/null 2>&1
apt-get install jq -y > /dev/null 2>&1
apt-get install curl -y > /dev/null 2>&1
apt-get install figlet -y > /dev/null 2>&1
apt-get install python3 -y > /dev/null 2>&1
apt-get install python-pip -y > /dev/null 2>&1
pip install speedtest-cli > /dev/null 2>&1
}
fun_bar 'inst_pct'
sleep 1
if [ -f "/usr/sbin/ufw" ] ; then
  ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
clear
echo ""
echo -e "               \033[1;33m● \033[1;32mFinalizando \033[1;33m●\033[0m"
echo ""
echo -e "      \033[1;33mConcluindo Funções e Definicoes! \033[0m"
echo ""
cd $_lsk
fun_bar 'source list'
rm sshplus* > /dev/null 2>&1
sleep 2
clear
apt-get install lsof > /dev/null 2>&1
echo ""
echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
echo -e "         \033[1;33m● \033[1;32mINSTALACAO CONCLUIDA \033[1;33m●\033[0m"
echo ""
echo -e "\033[1;31m● \033[1;33mProxy Squid Instalado, Portas: 80, 8080, 3128\033[0m"
echo -e "\033[1;31m● \033[1;33mOpenSSH rodando nas portas 22 e 443\033[0m"
echo -e "\033[1;31m● \033[1;33mScript para gerenciamento de usuários instalado\033[0m"
echo -e "\033[1;31m● \033[1;33mComandos disponíveis Execulte \033[1;32mmenu \033[1;33mou \033[1;32majuda\033[0m"
echo -e "\033[0;34m═════════════════════════════════════════════════\033[0m"
echo ""
sed -i "126d" /etc/ssh/sshd_config > /dev/null 2>&1
sed -i '$a Port 22' /etc/ssh/sshd_config  > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
cd $HOME
if [[ "$optiondb" = '2' ]]; then
  awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > $HOME/usuarios.db
fi
echo "$ipdovps" >/etc/IP
