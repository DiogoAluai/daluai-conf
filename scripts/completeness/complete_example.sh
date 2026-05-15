#!/usr/bin/bash

##
## Source this file to add completeness (tab) to clone-project script
## You might want to add this code to .bashrc
##

_command__complete() {
    local cur cache_dir
    cur="${COMP_WORDS[COMP_CWORD]}"
    some_dir_with_options="/somedir"
    COMPREPLY=( $(compgen -W "$(ls "$some_dir_with_options")" -- "$cur") )
}

complete -F _command_complete command1 command2 ...

