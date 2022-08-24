# vim: tabstop=4 shiftwidth=4 expandtab


# NeoFetch
[[ $PWD = $HOME ]] && neofetch&

# OneFetch
function onefetch_auto_env() {
    [[ -d .git ]] && onefetch --no-palette
}; onefetch_auto_env; chpwd_functions+=(onefetch_auto_env)

# key-bindings
bindkey -v
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



# Personal
export PATH="/home/wviana/bin:/home/wviana/.local/bin/:$PATH"
alias ls && unalias ls
function ls() { # Call exa when stdout is terminal, otherwise default ls command.
    if [ -t 1 ]; then
        exa --icons --sort=modified $@
    else
        env ls $@
    fi
}
alias ll="ls -l"
alias la="ll -a"
alias p="sudo pacman"
alias pk="pikaur"
alias docker="sudo docker"
alias r="ranger"
alias vim="nvim"
alias nv="nvim"
alias aria2c="echo Use axel instead"
alias open="exo-open"
alias pb="xsel -b"
eval "$(ssh-agent -s)" &> /dev/null

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
# setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

export EDITOR=nvim
export SUDO_EDITOR=$EDITOR
export KUBECONFIG="/home/wviana/.config/kubeconfig.yaml"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
wait ################## IMPORTANT #####################
