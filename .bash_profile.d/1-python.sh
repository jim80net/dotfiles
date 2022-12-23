export PATH=/home/linuxbrew/.linuxbrew/lib/python3.10/site-packages:$PATH # Prefer homebrew packages
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"
export PATH=$HOME/.pyenv/shims:$PATH

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
#pyenv virtualenvwrapper_lazy



