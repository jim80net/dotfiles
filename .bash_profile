export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
eval "$(starship init bash)"
for i in $(ls $HOME/dotfiles/.bash_profile.d/*.sh); do source $i; done

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/home/linuxbrew/.linuxbrew/opt/imagemagick@6/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
. "$HOME/.cargo/env"
