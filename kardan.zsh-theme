# Simple theme based on my old zsh settings.

function get_host {
	echo '@'`hostname`''
}

PROMPT="%{$fg[yellow]%}Ξ%{$reset_color%} "
RPROMPT='%~$(git_prompt_info)%{$fg[blue]%}$(get_host)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
