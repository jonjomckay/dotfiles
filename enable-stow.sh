#!/usr/bin/env sh

set -e

apps=(
    git
    i3
    openbox
    polybar
    rofi
    xfce4-terminal
    zsh
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    app=$1
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t ${HOME} ${app}
}

echo ""
echo "Stowing apps for user: ${whoami}"

# install apps available
for app in ${apps[@]}; do
    stowit $app 
done

echo ""
echo "Finished stowing"
