ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Kubectl edit command will use this env var.
export EDITOR=nano
# Should your editor deals with streamed vs on disk files differently, also set...
export K9S_EDITOR=nano

# export NODE_ENV=dev

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  kubectl
  dotenv
  last-working-dir
  zsh-autosuggestions
  yarn
  zsh-z
  zsh-completions
  zsh-npm-scripts-autocomplete
)

source $ZSH/oh-my-zsh.sh

[[ -r ~/zsh-plugins/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/zsh-plugins/znap

source ~/zsh-plugins/znap/znap.zsh  # Start Znap

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias la="ls -la"
alias c="code ."
alias y="yarn"
alias p="pnpm"
alias pnx="pnpm nx"
alias ..="cd .."
alias ...="cd ../.."
alias rm-node-modules="find . -type d -name \"node_modules\" -prune -exec rm -r {} +"

# Git
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias gfgc='git fetch && git checkout '
alias gbuu='git branch --unset-upstream'
alias gcb='git checkout -b '

# Docker
alias docker-stop-all='docker stop $(docker ps -aq)'

# iOS
alias ios-devices-ls="xcrun xctrace list devices"

# Python
alias py="python3"

# gRPC
alias grpc-gen="python -m grpc_tools.protoc -I. --python_out=. --pyi_out=. --grpc_python_out=."

# Earth Drilling
alias sw="yarn start:watch"
alias bw="yarn build:watch"
alias bcl="yarn build:clean"
alias sa="yarn app-config secret agent"

# Github Copilot
alias copilot="gh copilot"
alias gcs="gh copilot suggest"
alias gce="gh copilot explain"

# alias slint-create="cargo generate --git https://github.com/slint-ui/slint-rust-template --name my-project"
function slintcreate() {
  cargo generate --git https://github.com/slint-ui/slint-rust-template --name $1
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# export PATH="/opt/homebrew/opt/opencv@3/bin:$PATH"

# OpenCV
# export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/homebrew/Cellar/opencv/4.7.0_1/lib/pkgconfig
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/homebrew/Cellar/opencv/4.7.0_1/lib
# export CXXFLAGS="--std=c++17"export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Stripe autocompletion
fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Homeq
# export JAVA_HOME="/opt/homebrew/Cellar/openjdk/23.0.1/libexec/openjdk.jdk/Contents/Home"
export JAVA_HOME="$HOME/.sdkman/candidates/java/current/bin/java"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
alias copilot="gh copilot"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /opt/homebrew/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /opt/homebrew/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

export PYTHON=$(which python3.10)
export PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH
export PATH=$PATH:$HOME/.spicetify

export LDFLAGS="-L/opt/homebrew/opt/jpeg/lib"
export CPPFLAGS="-I/opt/homebrew/opt/jpeg/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/jpeg/lib/pkgconfig"

#tcl-tk
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# Function to create tar archive with progress
# Example usage: zip_with_progress /path/to/directory output.tar.gz
zip_with_progress() {
  if [ $# -lt 2 ]; then
    echo "Usage: zip_with_progress source_directory archive_name.zip"
    return 1
  fi

  local source_dir="$1"
  local archive_name="$2"

  # Calculate the total size of the files in the directory in kilobytes
  local total_size_kb=$(du -sk "$source_dir" | awk '{print $1}')

  # Convert kilobytes to bytes
  local total_size_bytes=$((total_size_kb * 1024))

  # Create zip archive with progress using pv and fastest compression (-1)
  # The -r flag is for recursive directory zipping
  # -1 uses the fastest compression algorithm
  find "$source_dir" -type f -print0 | pv -N "Compressing files" -s $total_size_bytes | xargs -0 zip -1 -r "$archive_name"
}

# Function to copy files with progress
# Example usage: cp_with_progress source_file destination
cp_with_progress() {
  if [ $# -lt 2 ]; then
    echo "Usage: cp_with_progress source destination"
    return 1
  fi

  local source="$1"
  local dest="$2"

  # Copy with progress using pv
  pv "$source" >"$dest"
}

# Function to compress a folder or file using zstd with specific options and show speed in Mbps
compress_with_zstd() {
  if [ $# -lt 2 ]; then
    echo "Usage: compress_with_zstd source destination.zst"
    return 1
  fi

  local source="$1"
  local dest="$2"

  # Calculate the total size of the source in kilobytes and convert to bytes
  local total_size_kb=$(du -sk "$source" | awk '{print $1}')
  local total_size_bytes=$((total_size_kb * 1024))

  # Use pv to show progress and convert speed from MiB/s to Mbps
  tar -cf - "$source" | pv -N "Compressing" -s $total_size_bytes | zstd -19 -T0 --ultra -22 --long=31 -o "$dest"
}

# Example usage:
# compress_with_zstd /path/to/source /path/to/destination.zst

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Auto `nvm use`
autoload -U add-zsh-hook
load-nvmrc() {
  # Check if the current directory is within ~/Development
  if [[ "$PWD" == ~/Development* ]]; then
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
      local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

      if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
      elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
      fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
      echo "Reverting to nvm default version"
      nvm use default
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

alias start-qzero="cd ~/Development/qzero-monorepo && source .env.josh && p dev"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Starship (p10k replacement)
eval "$(starship init zsh)"

# Zip a file and encrypt it with GPG
zip_and_encrypt() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: zip_and_encrypt <file_or_folder_to_compress> <output_file>"
    return 1
  fi

  local input="$1"
  local output="$2"
  local tar_file="${output}.tar"

  # Create a tar archive
  tar -cvf "$tar_file" "$input"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to create tar archive."
    return 1
  fi

  # Encrypt the tar file with GPG
  gpg --symmetric --cipher-algo AES256 --output "$output" "$tar_file"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to encrypt the file with GPG."
    rm -f "$tar_file" # Clean up the tar file if encryption fails
    return 1
  fi

  # Remove the intermediate tar file
  rm -f "$tar_file"

  echo "Successfully compressed and encrypted as $output"
  return 0
}

# Decrypt a file with GPG and unzip it with tar
decrypt_and_unzip() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: decrypt_and_unzip <encrypted_file.gpg> <output_directory>"
    return 1
  fi

  local encrypted_file="$1"
  local output_dir="$2"
  local tar_file="decrypted_file.tar"

  # Create the output directory if it doesn't exist
  mkdir -p "$output_dir"

  # Decrypt the .gpg file to a .tar archive
  gpg --output "$tar_file" --decrypt "$encrypted_file"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to decrypt the file."
    return 1
  fi

  # Extract the .tar archive into the output directory
  tar -xvf "$tar_file" -C "$output_dir"
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to extract the .tar file."
    rm -f "$tar_file" # Clean up the tar file if extraction fails
    return 1
  fi

  # Remove the intermediate .tar file
  rm -f "$tar_file"

  echo "Successfully decrypted and extracted to $output_dir"
  return 0
}

export PATH=$PATH:~/Library/Android/sdk/build-tools/36.0.0-rc1

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(zoxide init --cmd cd zsh)"

alias cd="z"

alias ls="eza --color=always --git --icons=always --octal-permissions --no-permissions --time-style=\"+%b %-d, %Y at %I:%M:%S %p\""

alias cat="bat"

alias tree="tre --color=always --all"

# eza catppuccin theme
export LS_COLORS="$(vivid generate catppuccin-mocha)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Doesn't work well with wezterm keybindings
# source ~/fzf-git.sh/fzf-git.zsh

export BAT_THEME="Catppuccin Mocha"

eval "$(atuin init zsh)"

tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }

export PATH="/usr/local/opt/postgresql/bin:$PATH"

alias claude="$HOME/.claude/local/claude"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Ruby gem binaries
export PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"