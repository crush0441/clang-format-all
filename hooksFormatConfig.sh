#!/bin/sh
#install git-hooks
if command -v git-hooks >/dev/null 2>&1; then 
  echo 'exists git-hooks' 

else 

  echo 'no exists git-hooks' 
  echo 'downloading .. .. ..'
  wget -P ~/ https://github.com/git-hooks/git-hooks/releases/download/v1.1.4/git-hooks_linux_amd64.tar.gz 
  mkdir ~/git-hooks	
  tar -zxvf ~/git-hooks_linux_amd64.tar.gz -C ~/git-hooks
  echo 'instaling......'
  sudo cp ~/git-hooks/build/git-hooks_linux_amd64 /usr/bin/git-hooks
  sudo chomod +x /usr/bin/git-hooks

fi

if command -v clang-format >/dev/null 2>&1; then 
  echo 'exitst clang-format'
else
  sudo apt-get install clang-format
  echo 'install clang-format'
fi

git-hooks install

if [ ! -f .clang-format ];then
echo 'create clang-formate config file !!'
clang-format -style="Google" -dump-config > .clang-format
else
echo 'clang-config-file exist'
fi

if [ ! -f clang-format-all ];then
echo 'get clang-format-all'
wget https://raw.githubusercontent.com/crush0441/clang-format-all/master/clang-format-all
chmod +x clang-format-all
else
echo 'clang-format-all exitst'
fi

mkdir -p githooks/pre-commit
echo '#!/bin/sh'>> githooks/pre-commit/format.sh
echo 'echo 'formating !!!''>> githooks/pre-commit/format.sh
echo './clang-format-all src'>> githooks/pre-commit/format.sh
echo './clang-format-all include'>> githooks/pre-commit/format.sh
chmod +x githooks/pre-commit/format.sh
echo 'config finished !!!!'
