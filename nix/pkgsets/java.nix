pkgs: with pkgs; [
  ( maven.override
      { jdk_headless = openjdk21_headless;
      }
  )
  ( jdt-language-server.override
      { jdk = openjdk21_headless;
      }
  )
]
