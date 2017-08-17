#!/usr/local/bin/fish

cd scripts/install

set -l execs (find . -type f)

for exec in $execs
  eval $exec
end
