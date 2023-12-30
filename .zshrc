# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="archcraft"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

plugins=(git thefuck zsh-autosuggestions zsh-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd


# source $HOME/.profile

# omz
alias zshconfig="geany ~/.zshrc"
alias ohmyzsh="thunar ~/.oh-my-zsh"

# ls
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
alias lm='ls -m'
alias lr='ls -R'
alias lg='ls -l --group-directories-first'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin master'

# neovim
alias vim='nvim'
alias vi='nvim'

####### My env
# Notification with sound
alias notify="bash $HOME/.my-env/commands/notify.sh"
alias notify-send="bash $HOME/.my-env/commands/notify.sh"

# menu launcher, open-apps = opps
alias opps="bash $HOME/.my-env/commands/opps.sh"

# Env mode
alias mode="bash $HOME/.my-env/env.sh"
alias myenv="bash $HOME/.my-env/env.sh"
alias m="bash $HOME/.my-env/env.sh"

if [[ "$(cat "$HOME/.my-env/env.txt")" == "neutral" ]]; then
  source $HOME/.my-env/environments/neutral_zsh.zsh
elif [[ "$(cat "$HOME/.my-env/env.txt")" == "coding" ]]; then
  source $HOME/.my-env/environments/coding_zsh.zsh
fi

# Pomodoro timer
alias pomo="bash $HOME/.my-env/apps/pomodoro.sh";
alias p="bash $HOME/.my-env/apps/pomodoro.sh";

########

source /usr/share/nvm/init-nvm.sh

# bun completions
[ -s "/home/guz/.bun/_bun" ] && source "/home/guz/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bum
export BUM_INSTALL="$HOME/.bum"
export PATH="$BUM_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/guz/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# rust
source "$HOME/.cargo/env"

