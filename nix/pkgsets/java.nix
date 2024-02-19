pkgs: with pkgs; [
  openjdk21
  ( gradle.override
      { java = openjdk21;
      }
  )
  ( jdt-language-server.override
      { jdk = openjdk21;
      }
  )
]
