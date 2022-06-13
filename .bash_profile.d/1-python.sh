eval "$(pyenv init -)"
export PATH=$HOME/.pyenv/shims:$PATH

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy
