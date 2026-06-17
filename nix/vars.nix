with builtins;

let
  lib               = (import  <nixpkgs> {}).lib;
  replace           = import ./replace.nix { inherit lib; };
  userConfig        = fromJSON (readFile (getEnv "DOTFILES_USER_CONFIG"));
  homefilesPath     = getEnv "DOTFILES_PATH" + "/homefiles";
  homefilesTmplPath = getEnv "DOTFILES_PATH" + "/homefile-templates";
in
{
  username      = getEnv "USER";
  homeDirectory = getEnv "HOME";
  homefiles     = mapAttrs
                    ( name: value: { source    = "${homefilesPath}/${name}";
                                     recursive = value == "directory";
                                   }
                    )
                    ( readDir homefilesPath )
                    // listToAttrs
                    ( map
                        ( path: { name  = path;
                                  value = { text   = replace.processTemplate (readFile path) userConfig;
                                            target = ( lib.strings.replaceString ( homefilesTmplPath + "/" ) "" path );
                                          };
                                }
                        )
                        ( lib.filesystem.listFilesRecursive homefilesTmplPath )
                    );
}
