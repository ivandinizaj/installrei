#!/bin/bash
NAME_REI="rei-cli"
DIR_ROOT="$HOME/.local/share"
DIR_LOCAL="$DIR_ROOT/$NAME_REI"
URL_REPOSITORY="git@gitlab.roadmaps.com.br:ivan/rei-cli.git"

renderLine() {
  printf "\n\n-------------------------"
}
# Verifica se o comando existe
# @example:  if ! testcmd shell; then //return true
# @return {boolean}
testcmd() {
  command -v "$1" >/dev/null
}
renderSuccess() {
  printf "\n ✅ CLI ADICIONADO COM SUCESSO \n "
  printf "\n veja mais em: https://gitlab.roadmaps.com.br/ivan/rei-cli"
}

installBin() {
  renderLine
  printf "\n 📢 ADICIONANDO NOSSO CLI 📢\n"
  cd /usr/local/bin
  if ! testcmd rei; then
    sudo ln -s $HOME/.local/share/rei-cli/bin/rei rei
  fi

}

installDependencies() {
  printf "\n⌛⏳ INSTALANDO DEPENDÊNCIAS ⌛⏳\n"
  npm install
  if [ $? -eq 0 ]; then
    installBin
    renderSuccess
  fi
}

renderProblemToDownload() {
  # Problema ao baixar reposítório
  renderLine
  printf "\n🚫 SEM PERMISSÃO PARA BAIXAR 🚫\n"
  printf "  verifique sua autenticação com ssh"
}

## Cria o local para baixar caso não exista
mkdir -p $DIR_ROOT

if [ ! -d "$DIR_LOCAL" ]; then
  cd $DIR_ROOT
  printf "\n⬇️  BAIXANDO REI ⬇️ \n"
  git clone $URL_REPOSITORY

  ## caso dê tudo certo para baixar
  if [ $? -eq 0 ]; then
    cd $DIR_LOCAL
    installDependencies
  else
    renderProblemToDownload
  fi

else
  cd $DIR_LOCAL
  printf "\n🔄  ATUALIZAR NOSSO REI 🔄 \n"
  git pull $URL_REPOSITORY
  if [ $? -eq 0 ]; then
    installDependencies
  else
    renderProblemToDownload
  fi
fi
