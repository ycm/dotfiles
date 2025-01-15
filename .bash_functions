fawk() {
    local delimiter="$1"
    local column="$2"
    local file="$3"

    local bold="\033[1m"
    local boldred="\033[1;31m"
    local boldgreen="\033[1;32m"
    local boldblue="\033[1;34m"
    local red="\033[31m"
    local green="\033[32m"
    local blue="\033[34m"
    local reset="\033[0m"

    if [[ -z "$delimiter" || -z "$column" || -z "$file" ]]; then
        echo -e "${bold}Usage: fawk ${boldred}<delimiter>${reset} ${boldgreen}<column> ${boldblue}<file>${reset}"
        echo -e "i.e. awk -v FS=${red}<delimiter>${reset} '{ print \$${green}<column>${reset} }' ${blue}<file>${reset}"
        return 1
    fi

    awk -v FS="$delimiter" "{ print \$${column} }" "$file"
}

extract() {
    local bold="\033[1m"
    local boldred="\033[1;31m"
    local reset="\033[0m"
    if [[ -z "$1" ]]; then
        echo -e "${bold}Usage: extract ${boldred}<filename>${reset}"
    elif [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xvjf $1   ;;
            *.tar.gz)  tar xvzf $1   ;;
            *.bz2)     bunzip2 $1    ;;
            *.rar)     unrar x $1    ;;
            *.gz)      gunzip $1     ;;
            *.tar)     tar xvf $1    ;;
            *.tbz2)    tar xvjf $1   ;;
            *.tgz)     tar xvzf $1   ;;
            *.zip)     unzip $1      ;;
            *.Z)       uncompress $1 ;;
            *.7z)      7z x $1       ;;
            *)         echo -e "don't know how to extract ${boldred}'$1'${reset}" ;;
        esac
    else
        echo -e "${boldred}'$1'${reset} is not a valid file!"
    fi
}

up() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

cj() {
    if [[ -z "$1" ]]; then
        local bold="\033[1m"
        local boldred="\033[1;31m"
        local red="\033[31m"
        local reset="\033[0m"
        echo -e "${bold}Usage: cj ${boldred}<char>${reset}"
        echo -e "i.e. grep ${red}<char>${reset} /usr/share/rime-data/cangjie5.dict.yaml"
        return 1
    fi

    grep --color=auto "$1" /usr/share/rime-data/cangjie5.dict.yaml
}
