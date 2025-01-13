
# The following lines were added by compinstall
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Do not auto select from menu with tab
unsetopt AUTO_MENU

eval "$(starship init zsh)"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

eval "$(nodenv init - zsh)"

# For zsh subshells, tell warp to "Warpify" subshells
# printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh"}}\x9c'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

##
# History
HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
# setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.

##
# bun completions
[ -s "/Users/parks/.bun/_bun" ] && source "/Users/parks/.bun/_bun"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/parks/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"

# Set title
#
set_iterm_title() {
	local title=""
	if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]];
	then
		local repo_root=$(git rev-parse --show-toplevel)
		local repo_name=$(basename "$repo_root")
		local physical_pwd=$(pwd -P)
		local relative_path="${physical_pwd##$repo_root}"
		local branch=$(git branch --show-current 2>/dev/null)

		if [[ -n "$branch" ]]; 
		then
		  title="$repo_name [$branch] - $relative_path"
		else
			local commit=$(git rev-parse --short HEAD 2>/dev/null)
			title="$repo_name [detached/$commit] - $relative_path"
		fi
	else
		title="$PWD"
	fi

	echo -ne "\e]1;${title}\a"
}

precmd() {
	set_iterm_title
}
