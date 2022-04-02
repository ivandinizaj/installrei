#!/bin/bash
NAME_REI="rei-cli"
DIR_ROOT="$HOME/.local/share"
DIR_LOCAL="$DIR_ROOT/$NAME_REI"
FILE_BIN="/usr/local/bin/rei"

# Verifica se o comando existe
# @example:  if ! testcmd shell; then //return true
# @return {boolean}
testcmd() {
  command -v "$1" >/dev/null
}

renderProblemToPermission() {
  # Problema ao baixar reposítório
  printf "🚫 SEM PERMISSÃO, AÍ TU NÃO ME AJUDA 🚫\n"
}

printf "\n"

if [ -d "$DIR_LOCAL" ]; then
  cd $DIR_ROOT
  rm -rf $NAME_REI

  ## caso dê tudo certo para baixar
  if [ $? -eq 0 ]; then
    printf "✅ REMOVIDO COM SUCESSO ✅\n"
  else
    renderProblemToPermission
  fi

else
  printf "❌ NÃO ENCONTRAMOS A PASTA DO REI ❌\n"
fi

if [ -f "$FILE_BIN" ]; then
  sudo rm -f $FILE_BIN

  ## caso dê tudo certo para baixar
  if [ $? -eq 0 ]; then
    printf "✅ BIN REMOVIDO COM SUCESSO ✅\n"
  else
    renderProblemToPermission
  fi

else
  printf "\n❌ NÃO ENCONTRAMOS O CLI ❌\n"
fi
