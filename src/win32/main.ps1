## @todo(stdmatt): Make a function that join any numer of paths with a sane syntax...
## @todo(stdmatt): Make a way to install fotnts automatically.
##
## Constants
##
$POWERSHELL_TELEMETRY_OPTOUT = 0;

## @TODO(stdmatt): Check if we want vi keybindings...
Set-PSReadLineOption -EditMode Vi

## General Paths...
$HOME_DIR        = "$env:USERPROFILE";
$DOWNLOADS_DIR   = "$HOME_DIR/Downloads";
$DOCUMENTS_DIR   = "$HOME_DIR/Documents";
$DESKTOP_DIR     = "$HOME_DIR/Desktop";
$STDMATT_BIN_DIR = "$HOME_DIR/.stdmatt_bin"; ## My binaries that I don't wanna on system folder...
$DOTS_DIR        = "$env:DOTS_DIR";
$PROJECTS_DIR    = "$DOCUMENTS_DIR/Projects/stdmatt";

## @todo(stdmatt): Find a better way to specify those paths... Feb 15, 2021
$LTY_DIR = "D:/LTY";
$ACK_DIR = "D:/ACK";

$WORKSTATION_PREFIX = "KIV-WKS";
$WORK_ME_PATH       = "E:/stdmatt";
$HOME_ME_PATH       = "$PROJECTS_DIR";

## Sync Paths...
$TERMINAL_SETTINGS_INSTALL_FULLPATH = "$HOME_DIR/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json";
$TERMINAL_SETTINGS_SOURCE_FULLPATH  = "$DOTS_DIR/extras/windows_terminal.json";

$PROFILE_INSTALL_FULLPATH = "$HOME_DIR/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"
$PROFILE_SOURCE_FULLPATH  = "$DOTS_DIR/src/win32/main.ps1";

$VIMRC_INSTALL_DIR     = "$HOME_DIR"
$VIMRC_SOURCE_FULLPATH = "$DOTS_DIR/extras/.vimrc";

$VSCODE_KEYBINDINGS_INSTALL_FULLPATH = "$HOME_DIR/AppData/Roaming/Code/User/keybindings.json";
$VSCODE_KEYBINDINGS_SOURCE_FULLPATH  = "$DOTS_DIR/extras/keybindings.json";

## Binary aliases...
$FILE_MANAGER        = "explorer.exe";
$YOUTUBE_DL_EXE_PATH = Join-Path -Path $STDMATT_BIN_DIR -ChildPath "youtube-dl.exe";

## Journal things...
$JOURNAL_DIR       = "$HOME_DIR/Desktop/Journal";
$JOURNAL_GIT_URL   = "https://gitlab.com/stdmatt-private/journal";

$JOURNAL_FILE_EXT = ".md";

##
## Helper Functions (Private)
##
##------------------------------------------------------------------------------
function _string_is_null_or_whitespace()
{
    return [string]::IsNullOrWhiteSpace($args[0]);
}

##------------------------------------------------------------------------------
function _string_contains()
{
    $haystack = $args[0];
    $needle   = $args[1];

    if((_string_is_null_or_whitespace $haystack)) {
        return $false;
    }
    if((_string_is_null_or_whitespace $needle)) {
        return $false;
    }

    $index = $haystack.IndexOf($needle);
    if( $index -eq -1) {
        return $false;
    }

    return $true;
}

##------------------------------------------------------------------------------
function _file_exists()
{
    return (Test-Path -Path $args[0] -PathType Leaf);
}

##------------------------------------------------------------------------------
function _dir_exists()
{
    ## @todo(stdmatt): How to chack only for dirs???
    return (Test-Path -Path $args[0]);
}

##------------------------------------------------------------------------------
function _log_fatal_func()
{
    ## @todo(stdmatt): Make it print the caller function, and print [FATAL] - Jan 14, 21
    echo "$args";
}

##------------------------------------------------------------------------------
$INVALID_FILE_TIME = -1;
function _get_file_time()
{
    if((_file_exists($args[0]))) {
        return (Get-Item $args[0]).LastWriteTimeUtc.Ticks;
    }
    return $INVALID_FILE_TIME;
}

##------------------------------------------------------------------------------
function _path_join()
{
    $fullpath = "";
    for ($i = 0; $i -lt $args.Length; $i++) {
        $fullpath += $($args[$i]);
        if($i -ne ($args.Length -1)) {
            $fullpath = $fullpath + "/";
        }
    }
    return $fullpath;
}

##
## Files
##   Open the Filesystem Manager into a given path.
##   If no path was given open the current dir.
##
##------------------------------------------------------------------------------
function files()
{
    $target_path = $args[0];

    if($target_path -ne "."                           -or
       $target_path -ne ".."                          -or
       (_string_is_null_or_whitespace($target_path))  -or
       (_file_exists                 ($target_path)))
    {
        if ( $target_path -eq "" )  {
            $target_path=".";
        }

        & $FILE_MANAGER $target_path;
        return;
    }

    _log_fatal_func("Path($target_path) doesn't not exists - Aborting...");
}

##------------------------------------------------------------------------------
function create-shortcut()
{
    $src_path = $args[0];
    $dst_path = $args[1];

    if ( _string_is_null_or_whitespace($src_path) ) {
        _log_fatal_func("Missing source path - Aborting...");
        return;
    }
    if ( _string/cm/_is_null_or_whitespace($dst_path) ) {
        _log_fatal_func("Missing target path - Aborting...");
        return;
    }

    $src_path = (Resolve-Path $src_path).ToString();

    ## @todo(stdmatt): Check if the string ends with .lnk and if not add it - Dec 28, 2020
    $WshShell            = New-Object -ComObject WScript.Shell
    $Shortcut            = $WshShell.CreateShortcut($dst_path);
    $Shortcut.TargetPath = $src_path;
    $Shortcut.Save();
}


##
## Ubisoft
##
##------------------------------------------------------------------------------
function lty
{
    cd $LTY_DIR;
    pwd
}

##------------------------------------------------------------------------------
function ack
{
    cd $ACK_DIR;
    pwd
}

##------------------------------------------------------------------------------
function clean-game-profile()
{
    rm $HOME_DIR/Documents/ProjectLiberty -Recurse
}

##------------------------------------------------------------------------------
function edit-game-ini()
{
    code --new-window $LTY_DIR/bin/scimitar.ini
}



##
## Paths
##
##------------------------------------------------------------------------------
function me
{
    $pc_name = hostname;
    $dst_dir = $HOME_ME_PATH;
    if((_string_contains $pc_name $WORKSTATION_PREFIX)) {
        $dst_dir = $WORK_ME_PATH;
    }

    cd $dst_dir;
    pwd
}

##------------------------------------------------------------------------------
function me-bin()
{
    cd $STDMATT_BIN_DIR;
    pwd;
}


##
## Profile
##
##------------------------------------------------------------------------------
function edit-profile()
{
    code $profile
}

##------------------------------------------------------------------------------
function reload-profile()
{
    . $profile
}

##------------------------------------------------------------------------------
function edit-profile()
{
    code $profile
}

##
## Sync...
##
##------------------------------------------------------------------------------
function _copy_newer_file()
{
    $filename_1 = $args[0];
    $filename_2 = $args[1];

    $time_1 = (_get_file_time $filename_1);
    $time_2 = (_get_file_time $filename_2);

    if($time_1 -eq $INVALID_FILE_TIME -and $time_2 -eq $INVALID_FILE_TIME) {
        _log_fatal_func("Both paths are invalid...`n    Path 1: ($filename_1)`n    Path 2: ($filename_2)");
        return;
    }

    $old_filename = $filename_1;
    $new_filename = $filename_2;

    if ($time_1 -lt $time_2) {
        $old_filename = $filename_2;
        $new_filename = $filename_1;
    }

    _log_fatal_func("[sync-profile] Copying ($old_filename) to ($new_filename)");
    Copy-Item $old_filename $new_filename -Force;
}

##------------------------------------------------------------------------------
function sync-profile()
{
    ## Terminal / Profile
    _copy_newer_file $TERMINAL_SETTINGS_INSTALL_FULLPATH $TERMINAL_SETTINGS_SOURCE_FULLPATH;
    _copy_newer_file $PROFILE_INSTALL_FULLPATH           $PROFILE_SOURCE_FULLPATH;

    ## .vimrc
    $vimrc_fullpath     = (_path_join $VIMRC_INSTALL_DIR  ".vimrc");
    $ideavimrc_fullpath = (_path_join $VIMRC_INSTALL_DIR ".ideavimrc");
    _copy_newer_file $vimrc_fullpath $VIMRC_SOURCE_FULLPATH;
    Copy-Item $vimrc_fullpath $ideavimrc_fullpath -Force;

    ## VSCode
    _copy_newer_file $VSCODE_KEYBINDINGS_INSTALL_FULLPATH $VSCODE_KEYBINDINGS_SOURCE_FULLPATH;
}

##------------------------------------------------------------------------------
function sync-journal()
{
    cd $JOURNAL_DIR;
    git add .

    $current_pc_name = hostname;
    $current_date    = date;
    $commit_msg      = "[sync-journal] ($current_pc_name) - ($current_date)";

    echo $commit_msg;
    git commit -m "$commit_msg";

    git pull
    git push
}

##------------------------------------------------------------------------------
function sync-dots()
{
    cd $DOTS_DIR;
    git add .

    $current_pc_name = hostname;
    $current_date    = date;
    $commit_msg      = "[sync-dots] ($current_pc_name) - ($current_date)";

    echo $commit_msg;
    git commit -m "$commit_msg";

    git pull
    git push
}

##------------------------------------------------------------------------------
function sync-all()
{
    sync-profile;
    sync-journal;
    sync-dots;
}


##
## Utils
##
##------------------------------------------------------------------------------
function journal()
{
    ## @todo(stdmatt): Would be nice to actually make the function to write
    ## the header automatically with the start and end dates of the week - 3/15/2021, 10:27:14 AM
    $cultureInfo = [System.Globalization.CultureInfo]::CurrentCulture;
    $week_day    = $cultureInfo.Calendar.GetWeekOfYear(
        (Get-Date),
        $cultureInfo.DateTimeFormat.CalendarWeekRule,
        $cultureInfo.DateTimeFormat.FirstDayOfWeek
    )

    ## This creates a new file with the date as filename if it doesn't exists...
    $curr_date_str    = "week_" + $week_day;
    $journal_filename = "$JOURNAL_DIR" + "/" + $curr_date_str + $JOURNAL_FILE_EXT;

    try {
        New-Item -Path "$journal_filename" -ItemType File -ea stop
    } catch {
    }

    ## @todo(stdmatt): Would be awesome to have the same-layout on vscode everytime.
    ## Check if it's possible to save a setup or pass command line options with this.
    ## Jan 14, 21
    code $JOURNAL_DIR;
}

##
## Shell
##
##------------------------------------------------------------------------------
function global:prompt
{
    $curr_path = pwd;
    return "$curr_path `n:) "
}

## @notice(stdmatt): This is pretty cool - It makes the cd to behave like
## the bash one that i can cd - and it goes to the OLDPWD.
## I mean, this thing is neat, probably PS has some sort of this like that
## but honestly, not in the kinda mood to start to look to all the crap
## microsoft documentation. But had quite fun time doing this silly thing!
## Kinda the first thing that I write in my standing desk here in kyiv.
## I mean, this is pretty cool, just could imagine when I get my new keychron!
## March 12, 2021!!
$global:OLDPWD="";
function _stdmatt_cd()
{
    $target_path = $args[0];

    if($target_path -eq "") {
        $target_path = "$HOME_DIR";
    }
    if($target_path -eq "-") {
        $target_path=$global:OLDPWD;
    }

    $global:OLDPWD =  [string](Get-Location);
    Set-Location $target_path; ## Needs to be the Powershell builtin or infinity recursion
}

Remove-Item -Path Alias:cd

Set-Alias -Name cd    -Value _stdmatt_cd                                 -Force -Option AllScope
Set-Alias -name rm    -Value C:\Users\stdmatt\.stdmatt_bin\ark_rm.exe    -Force -Option AllScope
Set-Alias -name touch -Value C:\Users\stdmatt\.stdmatt_bin\ark_touch.exe -Force -Option AllScope


##
## youtube-dl
##
##------------------------------------------------------------------------------
function _ensure_youtube_dl()
{
    if( -not(Test-Path -Path $YOUTUBE_DL_EXE_PATH) ) {
        echo "[youtube-dl-mp3] Could not find youtube-dl at ($YOUTUBE_DL_EXE_PATH)- Aborting...";
        return 0;
    }
    return 1;
}

##------------------------------------------------------------------------------
function youtube-dl-mp3()
{
    if(-not(_ensure_youtube_dl)) {
        return;
    }


    $URL = $args[0];
    if([string]::IsNullOrWhiteSpace($URL)) {
        echo "[youtube-dl-mp3] Empty url - Aborting...";
        return;
    }

    & $YOUTUBE_DL_EXE_PATH --no-playlist --extract-audio --audio-format mp3 $URL;
}

##------------------------------------------------------------------------------
function cmake-gen()
{
    $CMAKE_SCRIPT_FILENAME="CMakeLists.txt";
    $curr_dir = pwd;

    if(!(_file_exists $CMAKE_SCRIPT_FILENAME)) {
        _log_fatal_func "Current directory doesn't have a ($CMAKE_SCRIPT_FILENAME)";
        return;
    }

    ## @todo(stdmatt): Accept options:
    ##     - Path to cmake lists...
    ##     - Path to target dir....
    ##     - Build options...
    ## Jan 16, 21

    $BUILD_DIR = "build.win32";
    if(!(_dir_exists $BUILD_DIR)) {
        mkdir $BUILD_DIR;
    }

    # $CMAKE_BIN="$curr_dir/external/win32/cmake/bin/cmake.exe";
    cd $BUILD_DIR;
        cmake .. $args
    cd $curr_dir;
}

##------------------------------------------------------------------------------
function cmake-build()
{
    cmake-gen;

    $build_dir = "build.win32";
    $curr_dir  = pwd;

    if(!(_dir_exists $build_dir)) {
        _log_fatal_func "Build dir is not found: ($build_dir)";
        return;
    }

    cd $build_dir;
        cmake --build . --target ALL_BUILD $args
    cd $curr_dir;
}

# ##------------------------------------------------------------------------------
# function youtube-dl-playlist()
# {
#     local URL="$1";
#     test -z "$URL"                                              /
#         && echo "[youtube-dl-playlist] Empty url - Aborting..." /
#         return 1;

#     youtube-dl -o                                             /
#         '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' /
#         "$URL";
# }

# ##------------------------------------------------------------------------------
# function youtube-dl-music-playlist()
# {
#     local URL="$1";
#     test -z "$URL"                                              /
#         && echo "[youtube-dl-playlist] Empty url - Aborting..." /
#         return 1;

#     youtube-dl                                                /
#         --extract-audio --audio-format mp3                    /
#         -o                                                    /
#         '%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' /
#         "$URL";
# }