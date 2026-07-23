#!/usr/bin/env bash

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value

    option_value="$(tmux show-option -gqv "$option")"

    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

apply_minimal_theme() {
    # Theme options
    local bg_color
    local active_color
    local inactive_color
    local text_color
    local accent_color
    local border_color
    local icon_session
    local status_right

    bg_color=$(get_tmux_option "@minimal_theme_bg_color" "#1a1b26")
    active_color=$(get_tmux_option "@minimal_theme_active_color" "#7aa2f7")
    inactive_color=$(get_tmux_option "@minimal_theme_inactive_color" "#565f89")
    text_color=$(get_tmux_option "@minimal_theme_text_color" "#c0caf5")
    accent_color=$(get_tmux_option "@minimal_theme_accent_color" "#7aa2f7")
    border_color=$(get_tmux_option "@minimal_theme_border_color" "#414868")
    icon_session=$(get_tmux_option "@minimal_theme_session_icon" "")

    # Customizable status-right (default: empty)
    status_right=$(get_tmux_option "@minimal_theme_status_right" "")

    # Status bar
    tmux set-option -g status on
    tmux set-option -g status-position bottom
    tmux set-option -g status-interval 3
    tmux set-option -g status-justify left

    tmux set-option -g status-style "bg=$bg_color,fg=$text_color"
    tmux set-option -g status-left-length 100
    tmux set-option -g status-right-length 100

    # Pane
    tmux set-option -g pane-border-style "fg=$border_color"
    tmux set-option -g pane-active-border-style "fg=$active_color"

    # Messages
    tmux set-option -g message-style "bg=$bg_color,fg=$text_color,bold"
    tmux set-option -g message-command-style "bg=$bg_color,fg=$text_color,bold"

    # Windows
    tmux set-option -g window-status-format "#[fg=$inactive_color,bg=$bg_color] #I:#W "
    tmux set-option -g window-status-current-format "#[fg=$active_color,bg=$bg_color,bold] #I:#W "
    tmux set-option -g window-status-separator ""

    # Left
    tmux set-option -g status-left "#[fg=$accent_color,bold]$icon_session  #S #[fg=$inactive_color]│ "

    # Right
    tmux set-option -g status-right "$status_right"

    # Copy mode
    tmux set-option -g mode-style "bg=$active_color,fg=$bg_color"

    # Clock
    tmux set-option -g clock-mode-colour "$active_color"
    tmux set-option -g clock-mode-style 24
}
