function open --description 'open files/folders on Windows'
  explorer.exe (wslpath -w $argv)
end
