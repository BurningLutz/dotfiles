local wezterm = require "wezterm"


return {
  colors            = { foreground    = "#dcdfe4"
                      , background    = "#282c34"
                      , selection_fg  = "#000000"
                      , selection_bg  = "#FFFACD"
                      , cursor_fg     = "#282c34"
                      , cursor_bg     = "#dcdfe4"
                      , cursor_border = "#dcdfe4"
                      , ansi          = { "#282c34"
                                        , "#e06c75"
                                        , "#98c379"
                                        , "#e5c07b"
                                        , "#61afef"
                                        , "#c678dd"
                                        , "#56b6c2"
                                        , "#dcdfe4"
                                        }
                      , brights       = { "#5d677a"
                                        , "#e06c75"
                                        , "#98c379"
                                        , "#e5c07b"
                                        , "#61afef"
                                        , "#c678dd"
                                        , "#56b6c2"
                                        , "#dcdfe4"
                                        }
                      },

  window_padding    = { left   = 0
                      , right  = 0
                      , top    = 0
                      , bottom = 0
                      },
  line_height       = 0.95,

  font              = wezterm.font_with_fallback({
                        "Code New Roman",
                        "PingFang SC",
                      }),
  font_size         = 20,

  cursor_blink_rate = 500,

  enable_tab_bar    = false,

  scrollback_lines  = 32000,
}
