##------------------------------------------------------------------------------
export BASH_SILENCE_DEPRECATION_WARNING=1


##
## Important directories
##

##------------------------------------------------------------------------------
export BIN_DIR="${HOME}/.local/bin";
export CONFIG_DIR="${HOME}/.config";
export VAGRANT_DIR="${HOME}/.vagrant";
export NVIM_DIR="${CONFIG_DIR}/nvim";

[ -z "$TMPDIR" ] && TMPDIR=/tmp;
export TMPDIR;


##
## Shell
##

##------------------------------------------------------------------------------
## Terminal
## https://gist.github.com/sabinpocris/872bc3a557fbc448c2c9d95b62ede30d
export TERM="screen-256color";

## History
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "

## Editor / Pager
export EDITOR=$(which nvim || echo vim);
export VISUAL=$(which nvim || echo vim);
export PAGER=less;

## Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


##
## PATH
##

##------------------------------------------------------------------------------
if [ $bashy_IsGNU ]; then
    PATH_COMPONENTS=(
        ## My stuff...
        "${HOME}/.bin"
        "${HOME}/.bin/dots"
        "${HOME}/.local/bin"
        "${HOME}/.fzf/bin"
        ## Normal stuff...
        "/home/linuxbrew/.linuxbrew/bin"
        "/usr/local/bin"
        ## OS Stuff....
        "/usr/local/sbin"
        "/usr/local/bin"
        "/usr/sbin"
        "/usr/bin"
        "/sbin"
        "/bin"
    );
elif [ $bashy_IsMacOS ]; then
    PATH_COMPONENTS=(
        ## My stuff...
        "${HOME}/.bin"
        "${HOME}/.bin/dots"
        "${HOME}/.local/bin"
        "${HOME}/.fzf/bin"
        "${HOME}/.cargo/bin"
        ## @notice(java): OpenJDK needs to be put on path on macOS.
        "/usr/local/opt/openjdk/bin"
        ## @notice(gnu-tools): Add all the gnu tools to the path
        ## so we can use them in mac without prefixing with g.
        ##    find /usr/local/Cellar -iname "*gnubin" | sort
        "/usr/local/Cellar/coreutils/9.1/libexec/gnubin"
        "/usr/local/Cellar/ed/1.18/libexec/gnubin"
        "/usr/local/Cellar/findutils/4.9.0/libexec/gnubin"
        "/usr/local/Cellar/gawk/5.1.1/libexec/gnubin"
        "/usr/local/Cellar/gnu-indent/2.2.12_1/libexec/gnubin"
        "/usr/local/Cellar/gnu-sed/4.8/libexec/gnubin"
        "/usr/local/Cellar/gnu-tar/1.34_1/libexec/gnubin"
        "/usr/local/Cellar/gnu-which/2.21/libexec/gnubin"
        "/usr/local/Cellar/grep/3.7/libexec/gnubin"
        "/usr/local/Cellar/libtool/2.4.7/libexec/gnubin"
        ## OS Stuff....
        "/opt/X11/bin"
        "/usr/local/opt/curl/bin"
        "/usr/local/sbin"
        "/usr/local/bin"
        "/usr/sbin"
        "/usr/bin"
        "/sbin"
        "/bin"
    );
fi;

PATH=$(bashy_join_by ":" ${PATH_COMPONENTS[@]})
