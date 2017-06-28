function fish_prompt --description 'Write out the prompt'
    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    if __fish_vcs_prompt | grep -E '^ ?\(?master\)?$' > /dev/null
        set -g __fish_prompt_vcs (set_color red)
    else
        set -g __fish_prompt_vcs "$__fish_prompt_normal"
    end

    echo -n -s "$USER" @ (prompt_hostname) ' ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_vcs" (__fish_vcs_prompt) "$__fish_prompt_normal" '> '
end
