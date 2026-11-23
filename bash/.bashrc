# ~/.bashrc

# --- PATH (runs for every bash, interactive or not) ---------------------------
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# Everything below is for interactive shells only
case $- in
    *i*) ;;
    *) return ;;
esac

export EDITOR=nvim
export VISUAL=nvim

# --- History ------------------------------------------------------------------
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
shopt -s histappend cmdhist
# Write history after every command so tmux panes / new terminals share it
PROMPT_COMMAND="history -a${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# --- Shell options ------------------------------------------------------------
shopt -s checkwinsize globstar autocd 2>/dev/null

# --- Completion ---------------------------------------------------------------
if ! shopt -oq posix; then
    for f in /usr/share/bash-completion/bash_completion /etc/bash_completion; do
        if [ -r "$f" ]; then . "$f"; break; fi
    done
fi

# --- Prompt: teal cwd (matches the i3 theme) + git branch ---------------------
__git_branch() {
    local b
    b=$(git symbolic-ref --short -q HEAD 2>/dev/null) || b=$(git rev-parse --short HEAD 2>/dev/null) || return
    printf ' (%s)' "$b"
}
PS1='\[\e[38;5;73m\]\w\[\e[38;5;245m\]$(__git_branch)\[\e[0m\] \$ '

# --- Aliases ------------------------------------------------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
