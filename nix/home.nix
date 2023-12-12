{ config, pkgs, ... }:

with builtins;

let
  vars = import ./vars.nix;
in rec
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username      = vars.username;
  home.homeDirectory = vars.homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    clickhouse
    fd
    git
    git-lfs
    go
    gopls
    gradle
    haskellPackages.eventlog2html
    haskellPackages.threadscope
    htop
    jsbeautifier
    lua-language-server
    mongodb-tools
    nodePackages.typescript-language-server
    nodejs
    openjdk17
    pandoc
    pyright
    ripgrep
    tldr
    unzip
    ( jdt-language-server.override
        { jdk = openjdk17;
        }
    )
    ( neovim.override
        { extraMakeWrapperArgs = toString
                                   [ "--set LD_LIBRARY_PATH ${stdenv.cc.cc.lib}/lib"
                                     "--set NVIM_TREESITTER_COMPILER_PATH ${stdenv.cc}/bin/gcc"
                                   ];
        }
    )

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = vars.homefiles // {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lutz/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # fish shell needs mandb cache to do man completion.
  # the original cache format is not compatible with many systems, it should
  # be changed to gdbm.
  programs.man = with pkgs; {
    package        = man.override
                       { db = gdbm;
                       };
    generateCaches = true;
  };
}
