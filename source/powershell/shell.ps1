##------------------------------------------------------------------------------
(sh_log_verbose (sh_get_script_filename))

##
## ALIAS
##

$CONFIG = "${HOME_DIR}/.config";
$PS     = "${CONFIG}/powershell";
$NV     = "${CONFIG}/nvim";

##
## cd
##

##------------------------------------------------------------------------------
$global:OLDPWD="";
function _stdmatt_cd()
{
    ## @notice(stdmatt): This is pretty cool - It makes the cd to behave like
    ## the bash one that i can cd - and it goes to the OLDPWD.
    ## I mean, this thing is neat, probably PS has some sort of this like that
    ## but honestly, not in the kinda mood to start to look to all the crap
    ## microsoft documentation. But had quite fun time doing this silly thing!
    ## Kinda the first thing that I write in my standing desk here in kyiv.
    ## I mean, this is pretty cool, just could imagine when I get my new keychron!
    ## March 12, 2021!!

    ## @notice(stdmatt): This can be done just by calling sh_pushd and popd...
    ## maybe one day I'll move it - 22-04-08 @ guaruja
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

##------------------------------------------------------------------------------
Remove-Item -Path Alias:cd
Set-Alias -Force -Option AllScope -Name cd -Value _stdmatt_cd


##
## ls
##

##------------------------------------------------------------------------------
function _stdmatt_ls()
{
    exa --icons --git --classify --group-directories-first --no-permissions --no-filesize --no-user --no-time --long --grid $args;
}

##------------------------------------------------------------------------------
if($IsWindows) { Remove-Item -Path Alias:ls }
Set-Alias -Force -Option AllScope -Name ls -Value _stdmatt_ls;
Set-Alias -Force -Option AllScope -Name l  -Value _stdmatt_ls;


##
## Files
##

##------------------------------------------------------------------------------
function files()
{
    ## Open the Filesystem Manager into a given path.
    ## If no path was given open the current dir.
    $target_path = $args[0];
    if ($target_path -eq "") {
        $target_path=".";
    }

    $file_manager = "";
    if($IsWindows -or (sh_is_wsl)) {
        $file_manager = "explorer.exe";
    } elseif($IsMacOS) {
        $file_manager = "open";
    }
    ## @todo(stdmatt): Add for linux someday... at 2022-03-04, 15:54

    if($file_manager -eq "") {
        sh_log_fatal("No file manager was found - Aborting...");
        return;
    }

    if(-not (sh_dir_exists $target_path)) {
        sh_log_fatal("Invalid path - Aborting...");
        return;
    }

    & $file_manager $target_path;
    return;
}


##
## Make Link
##

##------------------------------------------------------------------------------
function make-link()
{
    $src_path = $args[0];
    $dst_path = $args[1];

    if (-not $src_path) {
        sh_log_fatal("Missing source path - Aborting...");
        return;
    }

    (sh_mklink $src_path $dst_path);
}


##
## kill
##
## @XXX(kill): Must change to Get-Process and refactor....
##------------------------------------------------------------------------------
function kill-process()
{
    $process_name = $args[0];
    $line         = (ps | grep $process_name);

    if($line.Length -eq 0) {
        sh_log_fatal "No process with name: (${process_name})";
        return;
    } elseif($line.Length -gt 1 -and $line.GetType().FullName -ne "System.String") {
        ## @todo(stdmatt): [Pretty Print] 09 Dec, 2021 at 00:58:30
        ## Print each process in a different line.
        sh_log_fatal "More than one process were found: (`n${line}`n)";
        return;
    }

    $comps_dirty = $line.Split(" ");
    $comps_clean = @();

    for($i = 0; $i -lt $comps_dirty.Length; $i += 1) {
        $comp = $comps_dirty[$i];
        if($comp.Length -eq 0) {
            continue;
        }
        $comps_clean += $comp;
    }

    $PROCESS_ID_INDEX_IN_PS_OUTPUT = 4;
    $process_id                    = $comps_clean[$PROCESS_ID_INDEX_IN_PS_OUTPUT];

    sh_log "Killing proccess: ($process_name id: ${process_id})";
    kill $process_id -Force
}


##
## Delete (rm)
##

##------------------------------------------------------------------------------
function nuke-dir()
{
    ## @improve(stdmatt): [Handle multiple args]
    $path_to_remove = $args[0];
    if($path_to_remove -eq "") {
        sh_log_fatal "No directory path was given";
        return;
    }

    $dir_is_valid = (sh_dir_exists $path_to_remove);
    if(-not $dir_is_valid) {
        sh_log_fatal "Path isn't a valid directory...";
        return;
    }

    if($IsWindows) {
        rm -Recurse -Force $path_to_remove;
    } else {
        rm -rf "$path_to_remove";
    }
}