#!/bin/bash

DOT_DIR="$HOME/dotfiles"
cd "${DOT_DIR}"
bash welcome.sh

function has () {
    type "$1" > /dev/null 2>&1;
}

if [ ! -d ${DOT_DIR} ]; then
    # clone 
    if has "git"; then
        git clone https://github.com/ptlx/dotfiles.git ${DOT_DIR}
    else
        echo "git is required"
        exit 1
    fi
    cd ${DOT_DIR}
    for f in *
    do
        [[ "$f" == ".git" ]] && continue
        [[ "$f" == ".gitignore" ]] && continue
        [[ "$f" == "README.md" ]] && continue
        [[ "$f" == "install.sh" ]] && continue
        ln -snf $DOT_DIR/"$f" $HOME/".$f"
        echo "Installed .$f"
    done
else
    echo "dotfiles already exists"
fi

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null

echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.bash_profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
git -C $(brew --repo homebrew/core) checkout master

# run link.sh in respective directory
for f in *
do
    if [ -d $f ] ; then
        # exclude that do not have installer.sh and link.sh
        [[ ! -f "${DOT_DIR}/${f}/installer.sh" ]] && continue
        . "${DOT_DIR}/${f}/installer.sh"
        [[ ! -f "${DOT_DIR}/${f}/link.sh" ]] && continue
        . "${DOT_DIR}/${f}/link.sh"
    fi
done
