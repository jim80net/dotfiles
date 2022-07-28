export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
eval "$(starship init bash)"
for i in $(ls $HOME/dotfiles/.bash_profile.d/*.sh); do source $i; done

export PATH="/home/linuxbrew/.linuxbrew/opt/imagemagick@6/bin:$PATH"
