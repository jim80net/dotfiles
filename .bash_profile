export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
eval "$(starship init bash)"
for i in $(ls $HOME/.bash_profile.d/*.sh); do source $i; done


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

. /home/linuxbrew/.linuxbrew/opt/asdf/asdf.sh
