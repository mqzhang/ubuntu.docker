eval "$(~/.rbenv/bin/rbenv init - bash)" 
eval "$(~/.pyenv/bin/pyenv init -)" 

jupyter lab --allow-root --config=/tmp/jupyter_lab_config.py
