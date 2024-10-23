pkgs: with pkgs; [
  ( jdt-language-server.override
      { jdk = openjdk21;
      }
  )
]
