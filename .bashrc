# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc


##########################
#My Configs
##########################

# Bash History
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000

# Colour codes
RED="\\[\\e[1;31m\\]"
GREEN="\\[\\e[1;32m\\]"
YELLOW="\\[\\e[1;33m\\]"
BLUE="\\[\\e[1;34m\\]"
MAGENTA="\\[\\e[1;35m\\]"
CYAN="\\[\\e[1;36m\\]"
WHITE="\\[\\e[1;37m\\]"
ENDC="\\[\\e[0m\\]"

# Set a two-line prompt. If accessing via ssh include 'ssh-session' message.
if [[ -n "$SSH_CLIENT" ]]; then ssh_message="-ssh_session"; fi
PS1="${MAGENTA}\t ${GREEN}\u ${WHITE}at ${YELLOW}\h${RED}${ssh_message} ${WHITE}in ${BLUE}\w \n${CYAN}\$${ENDC} "

# files types by color in terminal - Nord Theme
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

##########################
# Alias Files Directory Shortcuts
##########################
alias cd..="cd .."
alias .1="cd .."
alias .2="cd ../../"
alias ls="ls -lht --color=auto --group-directories-first"
alias la="ls -A"
alias ll="la"
alias count="ls * | wc -l"
alias cp='cp -vi' # asks in case of overwrite a file
alias mv='mv -vi' # asks in case of overwrite a file
alias mv='mv -vi' # asks in case of overwrite a file
alias bashrc="nano ~/.bashrc"
alias more=less



##########################
#Utils Alias
##########################
# FOR UBUNTU #alias update="sudo -- sh -c 'apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y; apt-get autoremove -y; apt-get autoclean -y'"
alias update="sudo -- sh -c 'dnf update -y; dnf upgrade -y; dnf autoremove -y; dnf clean all'"
alias myip="ip -f inet address | grep inet | grep -v 'lo$' | cut -d ' ' -f 6,13 && curl ifconfig.me && echo ' external ip'"
alias cpv="rsync -avh --info=progress2" # (ie) cpv SOURCE_FILE DESTINATION_FILE
alias ports='netstat -tulanp'
alias path='echo -e ${PATH//:/\\n}'


##########################
#SSH Connections
##########################
alias myserver="ssh -p 123456789 me@199.200.201.202" # before ~/.ssh/config configuration
alias myserver2="ssh myserver2" # after config


##########################
#Directory Shortcuts
##########################

alias movies="cd/shared/media/movies/"
alias public='cd /shared/public'
