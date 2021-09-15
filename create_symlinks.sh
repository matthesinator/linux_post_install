#!/bin/bash

# Things to do:
# ask if symlinks for /home directories should be created
# ask if dots should be copied or symlinked
# check if apt is ok or pacman should be used
# install packages (list tbd)
# install zsh, change default shell
# install oh-my-zsh
# 

ask_for_deletion () {
    read -p "${1} is a ${2}, delete? [y/n] " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	if [ -d $1 ]; then
	    rm -r $1
	else
	    rm $1
	fi
        return 0
    else
        echo "Linking of ${1} skipped."
	echo
        return 1
    fi
}

check_path () {
    if [ -L $1 ]; then
	dir_type="symlink"
    elif [ -f $1 ]; then
	dir_type="file"
    elif [ -d $1 ]; then
	dir_type="directory"
    fi

    if [ -n "$dir_type" ]; then
	ask_for_deletion $1 $dir_type
	local res=$?
	return $res
    fi

    return 0
}

echo "Creating symlinks for shared home."
echo
base_path="/media/shared/common-home"

while [ ! -d "$base_path" ]; do
    echo "Folder ${base_path} not found, enter base path."
    read  base_path
done

for file in "$@"
do
    new_path="/home/${USER}/${file}"
    if check_path $new_path; then
	ln -s "${base_path}/${file}" $new_path
	echo "Link for ${file} created."
	echo
    fi
done

read -p "Symlinks created, press any key to continue." -n 1
echo
