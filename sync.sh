#!/usr/bin/env bash

json="$(curl -Ls "https://aur.archlinux.org/rpc/?v=5&type=search&by=maintainer&arg=hayao")"
script_path="$( cd -P "$( dirname "$(readlink -f "${0}")" )" && pwd )"

package_list=($(echo "${json}" | jq -r ".results[] | .Name"))

for pkg in ${package_list[@]}; do
    git clone "https://aur.archlinux.org/${pkg}.git"
    rm -rf "${pkg}/.git"
done
