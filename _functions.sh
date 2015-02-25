#!/bin/sh

# usage: echo -e "$(f bold)$(fc cyan)?$(f off) ${1} $(f bold)[y/n]$(f off) "
# usage: Echo "$(f bold)$(fc cyan)?$(f off) ${1} $(f bold)[y/n]$(f off) "
# usage: Echo success "$(f bold)$(fc cyan)?$(f off) ${1} $(f bold)[y/n]$(f off) "
# usage: Echo debug "$(f bold)$(fc cyan)?$(f off) ${1} $(f bold)[y/n]$(f off) "
# if promptyn "Are you sure?"; then ls -al; fi


_get_color_code() {
    local color=$1
    local c_black=232
    local c_yellow=3
    local c_blue=4
    local c_purple=5
    local c_teal=6
    local c_grey_light=7
    local c_grey=8
    local c_red=9
    local c_green=10
    local c_orange=208
    local c_cyan=14
    local c_white=15

    local selected="c_${color}"
    eval "echo \$$selected"
}

_get_color() {
    local type=$1
    local color=$2
    if [ "$type" == "fg" ]; then
        type="38"
    else
        type="48"
    fi

    if [ "$color" == "off" ]; then
        echo -e "\e[$type;0m"
    else
        echo -e "\e[$type;5;$(_get_color_code ${color})m"
    fi

}

fc() {
    local color=$1
    _get_color fg $1
}

bc() {
    local color=$1
    _get_color bg $1
}

f (){
    local f_off=0
    local f_bold=1
    local f_dim=2
    local f_underline=3
    local f_hidden=4

    local selected="f_${1}"
    local nr=$(eval "echo \$$selected")
    echo -e "\e[${nr}m"
}


promptyn () {
    while true; do
        echo -e -n "$(f bold)$(fc cyan)?$(f off) ${1} $(f bold)[y/n]$(f off) "
        read yn

        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


print_title(){
    local title="$(fc cyan)$(f bold)$1$(f off)"
    local line="---------------------------------------------------"
    echo -e "${line}\n${title}\n${line}"
}

countdown(){
    echo -e "$(fc orange)$(f bold)3$(f off)"
    sleep 1
    echo -e "$(fc cyan)$(f bold)2$(f off)"
    sleep 1
    echo -e "$(fc green)$(f bold)1$(f off)"
    sleep 1
}

Echo() {
    local type=$1
    local msg=${2:-}


    if [ -z "$msg" ]; then
        msg="$type"
        type="info"
    fi
    local t_info="$(f bold)$(fc cyan)i  $(f off)"
    local t_ok="$(f bold)$(fc green)√  $(f off)"
    local t_success="$(f bold)$(fc green)√  $(f off)"
    local t_warn="$(f bold)$(fc yellow)!  $(f off)"
    local t_debug="$(f bold)$(fc blue)#  $(f off)"
    local t_verbose="$(f bold)$(fc blue)!! $(f off)"
    local t_error="$(f bold)$(fc red)✖  $(f off)"
    local t_fatal="$(f bold)$(fc red)☠ FATAL: $(f off)"
    local selected="t_${type}"
    local pre=$(eval "echo \$$selected")

    if [ "$type" == "debug" ]; then
        if [ "$is_debug" == "true" ]; then
            echo -e "${pre}${msg}$(f off)"
        fi
    elif [ "$type" == "verbose" ]; then
        if [ "$is_verbose" == "true" ]; then
            echo -e "${pre}${msg}$(f off)"
        fi
    elif [ "$type" == "fatal" ]; then
        echo -e "${pre}${msg}$(f off)"
        exit 1
    else
        echo -e "${pre}${msg}$(f off)"
    fi
}

Exec() {
    #local cmd="$*"

    #$(eval `echo "${cmd}"` 3>&1 1>&2 2>&3)
    #eval ${cmd} > /dev/null 2>&1
    IFS=';' read -a array <<< "$*"
    for element in "${array[@]}"
    do
        if [ "$is_debug" == "true" ]; then
            Echo debug "Executing $(fc orange)${element}$(f off)"
            if $element ; then
                Echo debug "Executed $(fc orange)${element}$(f off)"
            else
                Echo debug "Failed while doing ${element}. "
                Echo fatal "Command failed"
            fi
        else
            if $element > /dev/null 2>&1 ; then
                Echo verbose "Executed $(fc orange)${element}$(f off)"
            else
                Echo verbose "Failed while doing ${element}. "
                Echo fatal "Command failed"
            fi
        fi
    done

}

# _tar path/to/dir
#> creates dir.tar.gz containing everything in path/to/dir
# _tar newdir.tar.gz path/to dir
#> creates newdir.tar.gz containing everything in path/to/dir
_tar(){
    local filename=$1
    local dirname=$2
    if [ "$dirname" == "" ]; then
        dirname=$(basename "$filename")
        filename="${filename}.tar.gz"
    fi
    tar -zcvf $filename $dirname
}

_untar() {
    local filename=$1
    tar -zxvf $filename
}
