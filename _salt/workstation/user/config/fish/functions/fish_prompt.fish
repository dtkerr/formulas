function fish_prompt_custom_git
    if test -n (fish_git_prompt)
        set -l branch (string replace --regex "\)" "" \
            (string replace --regex " \(" " " (fish_git_prompt)))
        printf "%s%s" (set_color -o blue) $branch
    end
end

function fish_prompt_custom_venv
    if test -n "$VIRTUAL_ENV"
        printf " %s%s" (set_color -o yellow) (basename $VIRTUAL_ENV)
    end
end

function fish_prompt_custom_ruby
    if test -n "$RUBY_VERSION"
        printf " %s%s" (set_color -o red) $RUBY_VERSION
    end
end

function fish_prompt_custom_status
    if test $argv[1] -eq 0
        printf " %s»" (set_color normal)
    else
        printf " %s[%s] »" (set_color -o red) $argv[1]
    end
end

function fish_prompt
    set -l last_status $status

    printf "%s%s%s%s%s%s%s " \
        (set_color white) \
        (prompt_pwd) \
        (fish_prompt_custom_git) \
        (fish_prompt_custom_venv) \
        (fish_prompt_custom_ruby) \
        (fish_prompt_custom_status $last_status) \
        (set_color normal)
end
