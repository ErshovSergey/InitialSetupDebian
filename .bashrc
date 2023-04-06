# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

Last_Command=$? # Must come first!

# Различные варианты 'ls' (предполагается, что установлена GNU-версия ls)
#alias ee='nano '
alias nn='nano -u -c -i'
alias ll='ls -la'
alias la='ls -Al' # показать скрытые файлы
alias ls='ls -GF' # выделить различные типы файлов цветом
#alias ls='ls -hF --color' # выделить различные типы файлов цветом
alias lx='ls -lXB' # сортировка по расширению
alias lk='ls -lSr' # сортировка по размеру
alias lc='ls -lcr' # сортировка по времени изменения
alias lu='ls -lur' # сортировка по времени последнего обращения
alias lr='ls -lR' # рекурсивный обход подкаталогов
alias lt='ls -ltr' # сортировка по дате
alias lm='ls -al |more' # вывод через 'more'
alias tree='tree -Csu' # альтернатива 'ls'
if [ -f /usr/local/bin/multitail ]; then alias tail=/usr/local/bin/multitail; fi

HISTSIZE=5000
HISTFILESIZE=10000

export PATH=$PATH:/usr/sbin

shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTCONTROL="ignoredups"
shopt -s cmdhist

# Мой PROMPT. Когда пользователем - зеленый, когда рутом - красным.
# Reset
Color_Off='\e[0m' # Text Reset

# Regular Colors
Black='\e[0;30m' # Black
Red='\e[0;31m' # Red
Green='\e[0;32m' # Green
Yellow='\e[0;33m' # Yellow
Blue='\e[0;34m' # Blue
Purple='\e[0;35m' # Purple
Cyan='\e[0;36m' # Cyan
White='\e[0;37m' # White

# Bold
BBlack='\e[1;30m' # Black
BRed='\e[1;31m' # Red
BGreen='\e[1;32m' # Green
BYellow='\e[1;33m' # Yellow
BBlue='\e[1;34m' # Blue
BPurple='\e[1;35m' # Purple
BCyan='\e[1;36m' # Cyan
BWhite='\e[1;37m' # White

# Underline
UBlack='\e[4;30m' # Black
URed='\e[4;31m' # Red
UGreen='\e[4;32m' # Green
UYellow='\e[4;33m' # Yellow
UBlue='\e[4;34m' # Blue
UPurple='\e[4;35m' # Purple
UCyan='\e[4;36m' # Cyan
UWhite='\e[4;37m' # White

# Background
On_Black='\e[40m' # Black
On_Red='\e[41m' # Red
On_Green='\e[42m' # Green
On_Yellow='\e[43m' # Yellow
On_Blue='\e[44m' # Blue
On_Purple='\e[45m' # Purple
On_Cyan='\e[46m' # Cyan
On_White='\e[47m' # White

# High Intensity
IBlack='\e[0;90m' # Black
IRed='\e[0;91m' # Red
IGreen='\e[0;92m' # Green
IYellow='\e[0;93m' # Yellow
IBlue='\e[0;94m' # Blue
IPurple='\e[0;95m' # Purple
ICyan='\e[0;96m' # Cyan
IWhite='\e[0;97m' # White

# Bold High Intensity
BIBlack='\e[1;90m' # Black
BIRed='\e[1;91m' # Red
BIGreen='\e[1;92m' # Green
BIYellow='\e[1;93m' # Yellow
BIBlue='\e[1;94m' # Blue
BIPurple='\e[1;95m' # Purple
BICyan='\e[1;96m' # Cyan
BIWhite='\e[1;97m' # White

# High Intensity backgrounds
On_IBlack='\e[0;100m' # Black
On_IRed='\e[0;101m' # Red
On_IGreen='\e[0;102m' # Green
On_IYellow='\e[0;103m' # Yellow
On_IBlue='\e[0;104m' # Blue
On_IPurple='\e[0;105m' # Purple
On_ICyan='\e[0;106m' # Cyan
On_IWhite='\e[0;107m' # White


set_prompt () {
local last_command=$? # Must come first!
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@`hostname -I` \h: \w\a\]"

local COLOR1="$BIGreen" # user name, prompt
local COLOR2="$Green" # hostname
local COLOR3="$IGreen" # command
local COLOR4="$Cyan" # date time
local COLOR5="$BRed" # error
local checkmark='\342\234\223'
local fancyX='\342\234\227'

prompt_str=">"
if [ `whoami` = "root" ]
then
COLOR1="$BIRed"
prompt_str="#"
fi

# если предыдущая команда вернула ошибку
if [[ $last_command != 0 ]]; then
PS1+="error:\[$COLOR5\]\[$last_command\] \n"
fi

PS1+="\[$COLOR2\][\[$COLOR1\]\u\[$COLOR2\]@\H]\[$COLOR3\] \w\[$COLOR4\] \D{%F %T} \[$COLOR1\]\$prompt_str \[$Color_Off\]"

}

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

bind '"\eOC": forward-word'
bind '"\eOD": backward-word'


shopt -s autocd

if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi

complete -cf sudo

PROMPT_COMMAND='set_prompt'


alias dclean='docker ps -aq | xargs --no-run-if-empty docker rm'
alias dcleanvol="docker volume ls | awk '/^local/ { print \$2 }' | xargs --no-run-if-empty docker volume rm"
alias ddangling='docker images --filter dangling=true -q | sort -u | xargs --no-run-if-empty docker rmi'

if [ ! "$TMUX" ]; then
# tmux attach || tmux new-session \; split-window -v \; split-window -h \; select-layout main-vertical;
tmux attach || tmux new-session ;
fi

if [ `whoami` != "root" ]
then
[ -f /usr/bin/cmatrix ] && cmatrix -a -B
fi
