#!/usr/bin/env sh

usage() {
    echo "usage: butler.sh export_name itch_username/itch_project [butler_binary]"
}

if [ "$1" == "help" ]; then
    usage; exit 0
fi

export_name="$1"
itch_string="$2"
butler_bin="${3:-butler}"

check_arg() {
    if [ "$1" == "" ]; then
        echo "$2"; usage
        exit 1
    fi
}

check_arg "$export_name" "no export name is passed"
check_arg "$itch_string" "no itch username/project string is passed"

push_build() {
    platform="$1"
    echo "pushing $platform build to $itch_string..."
    $butler_bin push "builds/$export_name/$platform" "$itch_string:$platform"
}

push_build "linux"
push_build "osx"
push_build "windows"
push_build "html5"