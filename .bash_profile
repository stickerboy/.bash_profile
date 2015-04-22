#################################################################################
# ~/.bashrc -- modified
#
# Last Updated: Probably today
#
################################################################################


# EXPORTS
################################################################################

export PS1="\n[\[\033[1;37m\@ :: \w\[\033[0m]\n[digital@wizzard] $ "

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# FUNCTIONS
################################################################################

lsmod() {
    ls -al | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
    *2^(8-i));if(k)printf("%0o ",k);print}'
}

get_logs() {
    cat /Applications/mamp/apache2/logs/$1
}
alias logs='get_logs'

gitstats() {
    git log --stat --author $(git config --get user.email) --since="last year" --until="last month" | awk -F',' '/files? changed/ {
        files += $1
        insertions += $2
        deletions += $3
        print
    }
    END {
        print "Files Changed: " files
        print "Insertions: " insertions
        print "Deletions: " deletions
        print "Lines changed: " insertions + deletions
    }'
}

# ALIAS COMMANDS
################################################################################

alias bashme='sudo vim ~/.bash_profile'
alias bashed='source ~/.bash_profile'
alias rc='cat ~/.bash_profile'

alias flush='sudo discoveryutil mdnsflushcache;sudo discoveryutil udnsflushcaches;say flushed' #for yosemite
alias flush2='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed' #for 10.9 and and below

alias start='sudo /Applications/mamp/ctlscript.sh start'
alias restart='sudo /Applications/mamp/ctlscript.sh restart'
alias stop='sudo /Applications/mamp/ctlscript.sh stop'

alias hosts='sudo vim /private/etc/hosts'
alias vhosts='sudo vim /Applications/mamp/apache2/conf/extra/httpd-vhosts.conf'
alias conf='sudo vim /Applications/mamp/apache2/conf/httpd.conf'
alias www='cd /Applications/mamp/apache2/htdocs/'

alias ..='cd ..'
alias la='lsmod'
alias bot='ruby ~/irc-scripts/bot.rb'

# Alias some git commands
alias status='git status'
alias check='git checkout'
alias checkout='git checkout'
alias pull='git pull'
alias branch='git branch'
alias tag='git tag'
alias fetch='git fetch'
alias clone='git clone'
alias commit='git commit -m'
alias push='git push'
function cherry() { git cherry-pick $1; }
function cherrypick() { git cherry-pick $1; }
alias undo='git reset --soft ^HEAD'

# Git FTP
alias ftpush='git ftp push'
alias ftpull='git ftp pull'
alias ftpinit='git ftp init'
alias ftpdown='git ftp bootstrap'
alias ftphelp='git ftp help --man'
alias ftplog='git ftp log'
alias ftpshow='git ftp show'
