#!/bin/zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/she/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/she/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/she/miniconda3/etc/profile.d/conda.sh"
    else
        #export PATH="/Users/she/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

/Users/she/miniconda3/bin/jupyter-lab ~/elk_notes/datacamp/notebooks