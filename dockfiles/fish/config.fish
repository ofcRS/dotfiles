set -gx PATH $PATH ~/linux/bin $HOME/yandex-cloud/bin $HOME/.nvm/versions/node/v18.19.0/bin /opt/romebrew/opt/postgresql@15/bin $HOME/bin /usr/local/bin $HOME/.cargo/bin /usr/local/bin /System/Cryptexes/App/usr/bin /usr/bin /bin /usr/sbin /sbin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin /var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin /usr/local/munki $HOME/linux/bin $HOME/nvim-macos/bin /opt/brew/bin /opt/homebrew/bin

set EDITOR nvim
set VISUAL nvim
set PAGER less
set LESS -R

function ls 
    command lsd -1l --group-dirs first $argv
end

 # TokyoNight Color Palette
 set -l foreground c0caf5
 set -l selection 2e3c64
 set -l comment 565f89
 set -l red f7768e
 set -l orange ff9e64
 set -l yellow e0af68
 set -l green 9ece6a
 set -l purple 9d7cd8
 set -l cyan 7dcfff
 set -l pink bb9af7

 # Syntax Highlighting Colors
 set -g fish_color_normal $foreground
 set -g fish_color_command $cyan
 set -g fish_color_keyword $pink
 set -g fish_color_quote $yellow
 set -g fish_color_redirection $foreground
 set -g fish_color_end $orange
 set -g fish_color_option $pink
 set -g fish_color_error $red
 set -g fish_color_param $purple
 set -g fish_color_comment $comment
 set -g fish_color_selection --background=$selection
 set -g fish_color_search_match --background=$selection
 set -g fish_color_operator $green
 set -g fish_color_escape $pink
 set -g fish_color_autosuggestion $comment

 # Completion Pager Colors
 set -g fish_pager_color_progress $comment
 set -g fish_pager_color_prefix $cyan
 set -g fish_pager_color_completion $foreground
 set -g fish_pager_color_description $comment
 set -g fish_pager_color_selected_background --background=$selection


set -x LESS_TERMCAP_mb (printf "\e[1;32m")
set -x LESS_TERMCAP_md (printf "\e[1;32m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[1;4;31m")


