#!/usr/local/bin/fish

cd links

set -l items (find . -type f | sed "s|^\./||")

for item in $items
  set -l filepath ~/{$item}
  set -l basepath (dirname $filepath)
  mkdir -p $basepath
  ln -sf $PWD/$item $basepath
end
