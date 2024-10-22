pkgs: with pkgs; [
  ( gradle.override
      { java = openjdk21;
      }
  )
  ( jdt-language-server.override
      { jdk = openjdk21;
      }
  )
]
