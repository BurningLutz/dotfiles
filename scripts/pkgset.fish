set BASE (dirname (status filename))
set -x PKGSETS_STATE_PATH ~/.local/state/dotfiles/pkgsets
set -x PKGSETS_BUILT_PATH ~/.config/home-manager/pkgsets
set -x PKGSETS_PATH       $BASE/../nix/pkgsets


function include -a pkgset
  argparse --name="pkgset include" "all" -- $argv
  or exit 2

  # --all is used.
  if set -q _flag_all
    for pkgset in (ls $PKGSETS_PATH)
      include $pkgset
    end

    return
  # no pkgset is provided.
  else if test -z $pkgset
    echo No package set provided.
    exit 3
  else
    set pkgset (basename $pkgset)

    # pkgset not available.
    if ! test -e $PKGSETS_PATH/$pkgset
      echo Package set `$pkgset` is not available.
      exit 4
    end

    read_pkgsets pkgsets

    if ! contains $pkgset $pkgsets
      # sort pkgsets first.
      set pkgsets (string collect -- $pkgsets $pkgset | sort)
      write_pkgsets pkgsets
    end
  end
end


function exclude -a pkgset
  argparse --name="pkgset exclude" "all" -- $argv
  or exit 2

  # --all is used.
  if set -q _flag_all
    rm -f $PKGSETS_STATE_PATH

    return
  # no pkgset is provided.
  else if test -z $pkgset
    echo No package set provided.
    exit 3
  else
    set pkgset (basename $pkgset)

    read_pkgsets pkgsets

    if set ix (contains -i $pkgset $pkgsets)
      set -e pkgsets[$ix]
    else
      echo Package set `$pkgset` is not included.
      exit 5
    end

    # no pkgsets left, remove the file.
    if test (count $pkgsets) -eq 0
      rm -f $PKGSETS_STATE_PATH
    else
      write_pkgsets pkgsets
    end
  end
end


function read_pkgsets -S -a var
  if test -e $PKGSETS_STATE_PATH
    set $var (cat $PKGSETS_STATE_PATH)
  end
end


function write_pkgsets -S -a var
  mkdir -p (dirname $PKGSETS_STATE_PATH)
  string collect -- $$var > $PKGSETS_STATE_PATH
end


function copy_pkgsets -S
  read_pkgsets pkgsets

  for pkgset in $pkgsets
    set pkgset_path $PKGSETS_PATH/$pkgset
    if test -e $pkgset_path
      cp $pkgset_path $PKGSETS_BUILT_PATH/$pkgset
    end
  end
end


function list
  # test if file exists and is not empty.
  if test -e $PKGSETS_STATE_PATH; and test -s $PKGSETS_STATE_PATH
    read_pkgsets pkgsets

    echo Included package sets are:
    for pkgset in $pkgsets
      if test -e $PKGSETS_PATH/$pkgset
        echo $pkgset
      else
        echo $pkgset '(missing)'
      end
    end
  else
    echo No package set included.
  end

  # test if file exists and is not empty.
  if test -e $PKGSETS_BUILT_PATH; and test -s $PKGSETS_BUILT_PATH
    set pkgsets (ls $PKGSETS_BUILT_PATH)

    echo Built package sets are:
    for pkgset in $pkgsets
      echo $pkgset
    end
  else
    echo No package set built.
  end
end
