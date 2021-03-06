source /etc/zsh/zpreztorc
source /usr/lib/prezto/init.zsh
source /usr/lib/prezto/runcoms/zshrc
source /etc/profile.d/fzf.zsh

PATH="/home/simon/bin:$PATH"
PATH=$PATH:/home/simon/.gem/ruby/1.9.1/bin:/home/simon/.cabal/bin
export PATH
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export EDITOR="vim"
export SHELL="/bin/zsh"

alias mvn="color_maven"
alias maven="/usr/bin/mvn"
alias rm="rm -I"

alias ino="nocorrect ino"

# Base16 Shell
BASE16_SCHEME="default"
BASE16_SHELL="/usr/share/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Fix cursor highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]=underline

# Colorize maven output
color_maven() {
  local BOLD=`tput bold`
  local TEXT_RED=`tput setaf 1`
  local TEXT_GREEN=`tput setaf 2`
  local TEXT_YELLOW=`tput setaf 3`
  local RESET_FORMATTING=`tput sgr0`

  /usr/bin/mvn $@ | sed -e "s/\(\[INFO\]\ \-\-\-\ .*\)/${TEXT_BLUE}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ \[.*\)/${RESET_FORMATTING}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ \)\(BUILD SUCCESS\)/\1${TEXT_GREEN}\2${RESET_FORMATTING}/g" \
    -e "s/\(\[INFO\]\ \)\(BUILD FAILURE\)/\1${TEXT_RED}\2${RESET_FORMATTING}/g" \
    -e "s/\(\[WARNING\].*\)/${TEXT_YELLOW}\1${RESET_FORMATTING}/g" \
    -e "s/\(\[ERROR\]\)/${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/\(Exception in thread \".*\" \)\(.*\)/\1${TEXT_RED}\2${RESET_FORMATTING}/g" \
    -e "s/\(SUCCESS \)\[/${RESET_FORMATTING}${TEXT_GREEN}\1${RESET_FORMATTING}\[/g" \
    -e "s/\(FAILURE \)\[/${RESET_FORMATTING}${TEXT_RED}\1${RESET_FORMATTING}\[/g" \
    -e "s/\(Caused by: \)\([^:\t ]*\)/\1${TEXT_RED}\2${RESET_FORMATTING}/g" \
    -e "s/\(ERROR\ \[.*\)/${TEXT_RED}\1${RESET_FORMATTING}/g" \
    -e "s/Tests run: \([^,]*\), Failures: \([^,0]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${TEXT_GREEN}Tests run: \1${RESET_FORMATTING}, Failures: ${TEXT_RED}\2${RESET_FORMATTING}, Errors: ${TEXT_RED}\3${RESET_FORMATTING}, Skipped: ${TEXT_YELLOW}\4${RESET_FORMATTING}/g"

  echo -ne ${RESET_FORMATTING}
}
