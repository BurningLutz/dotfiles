with builtins;

let
  homefilesPath = getEnv "DOTFILES_PATH" + "/homefiles";
in
{
  username      = getEnv "USER";
  homeDirectory = getEnv "HOME";
  homefiles     = mapAttrs
                    ( name: value: { source    = "${homefilesPath}/${name}";
                                     recursive = value == "directory";
                                   }
                    )
                    ( readDir homefilesPath );
}
