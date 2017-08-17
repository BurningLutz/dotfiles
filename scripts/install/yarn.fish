#!/usr/local/bin/fish

if not brew ls --versions yarn > /dev/null
  brew install yarn

  yarn global add eslint \
     eslint-plugin-react \
            babel-eslint \
        create-react-app \
             js-beautify
end

