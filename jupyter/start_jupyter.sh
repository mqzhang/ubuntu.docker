# eval "$(~/.rbenv/bin/rbenv init - bash)"
# eval "$(~/.pyenv/bin/pyenv init -)"

eval "$(mise activate bash)"

jupyter lab --allow-root --config=/tmp/jupyter_lab_config.py
