# Check for admin rights
function am_admin {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $p = New-Object System.Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (am_admin)) {
    Write-Error "Administration Rights not given! Please Run install.ps1 as Administrator";
    Exit;
}

$default_editor = "code"

# ###################### Start Installation ######################

######
### CHECK: Termify Path is set
######

if (-not $Env:TERMIFY_Path) {
    # Ask for Custom Dir
    $dir_termify = $home + "\.terminal\Termify";
    # Make New Directory
    mkdir $dir_termify;
    # Add to Environment Var
    $Env:TERMIFY_Path = $dir_termify;
}
# Set termify dir as working directory
Set-Location $dir_termify;

######
### CHECK: Editor is Set
######

if (-not $Env:TERMIFY_Editor) {
    $check_command = $default_editor;
    try {
        if (Get-Command $check_command) { 
            Write-Host "$check_command exist!"
        }
    } Catch {
        Write-Host "$check_command does not exist!"
        $default_editor = "notepad";
    }
    $Env:TERMIFY_Editor = $default_editor;
}

######
### FONTS: Install Fonts if not installed
######


######
### COPY_FILEs: Copy all ps1 file
######
