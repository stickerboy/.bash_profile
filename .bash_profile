alias flush='sudo killall -HUP mDNSResponder'
alias flush2='sudo dscacheutil -flushcache'
alias start='sudo /Applications/mamp/ctlscript.sh start'
alias restart='sudo /Applications/mamp/ctlscript.sh restart'
alias stop='sudo /Applications/mamp/ctlscript.sh stop'
alias bashme='sudo vim ~/.bash_profile'
alias bashed='source ~/.bash_profile'
alias hosts='sudo vim /private/etc/hosts'
alias vhosts='sudo vim /Applications/mamp/apache2/conf/extra/httpd-vhosts.conf'
alias conf='sudo vim /Applications/mamp/apache2/conf/httpd.conf'
alias www='cd /Applications/mamp/apache2/htdocs/'
alias ..='cd ..'
alias la='ls -a'
alias bot='ruby ~/irc-scripts/bot.rb'

lsmod() {
    ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) \
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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
