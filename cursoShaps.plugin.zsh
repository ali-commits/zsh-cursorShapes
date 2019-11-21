# ------------------------------------------------------------------------------
# Description
# -----------
#
# change the shape of cursor depends on the current vi mode of zsh termenal
#
# ------------------------------------------------------------------------------
# Authors
# -------
#
# * Ali Alrabeei <newaaa4@gmail.com>
#
# ------------------------------------------------------------------------------
# vession
# -----------
#
# 0.1.0 beta
#
# ------------------------------------------------------------------------------

function zle-keymap-select() {
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 == 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
    [[ ${KEYMAP} == viins ]] ||
    [[ ${KEYMAP} == '' ]] ||
    [[ $1 == 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}

zle -N zle-line-init

echo -ne '\e[5 q'                # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q'; } # Use beam shape cursor for each new prompt.


### Edit line in vi with ctrl+e
autoload edit-command-line
zle -N edit-command-line
edit-in-vim(){
	set VISUAL = vim
	set EDITOR = vim	
	[[ -z $BUFFER ]] && zle up-history
	edit-command-line
}
bindkey '^e' edit-in-vim
