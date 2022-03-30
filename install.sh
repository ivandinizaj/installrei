#!/bin/bash
NAME_REI="rei-cli"
DIR_ROOT="$HOME/.local/share"
DIR_LOCAL="$DIR_ROOT/$NAME_REI"
URL_REPOSITORY="git@gitlab.roadmaps.com.br:ivan/rei-cli.git"

renderLine() {
  echo "\n\n-------------------------"
}
# Verifica se o comando existe
# @example:  if ! testcmd shell; then //return true
# @return {boolean}
testcmd() {
  command -v "$1" >/dev/null
}
renderSuccess() {
  echo "\n ✅ CLI ADICIONADO COM SUCESSO \n "
  echo "\n veja mais em: https://gitlab.roadmaps.com.br/ivan/rei-cli"
}

installBin() {
  renderLine
  echo "\n 📢 ADICIONANDO NOSSO CLI 📢\n"
  cd /usr/local/bin
  if ! testcmd rei; then
    sudo ln -s $HOME/.local/share/rei-cli/bin/rei rei
  fi

}

installDependencies() {
  echo "\n⌛⏳ INSTALANDO DEPENDÊNCIAS ⌛⏳\n"
  npm install
  if [ $? -eq 0 ]; then
    installBin
    renderSuccess
  fi
}

renderProblemToDownload() {
  # Problema ao baixar reposítório
  renderLine
  echo "\n🚫 SEM PERMISSÃO PARA BAIXAR 🚫\n"
  echo "  verifique sua autenticação com ssh"
}

if [ ! -d "$DIR_LOCAL" ]; then
  cd $DIR_ROOT
  echo "\n⬇️  BAIXANDO REI ⬇️ \n"
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
  echo "\n🔄  ATUALIZAR NOSSO REI 🔄 \n"
  git pull $URL_REPOSITORY
  if [ $? -eq 0 ]; then
    installDependencies
  else
    renderProblemToDownload
  fi
fi
