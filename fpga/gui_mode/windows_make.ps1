# do $. ./windows_make.ps1 to source this file in powershell, then call the functions

# Define variables
$GUI_MODE_ROOT = $PSScriptRoot
$VIVADO_OUTPUT_DIR = Join-Path $GUI_MODE_ROOT "vivado_output"
$SCRIPT_DIR = Join-Path $GUI_MODE_ROOT "script"
$PROJECT_NAME = "aspir_dsp_modem"

# Function to create the project
function create_project {
    $createProjectScript = Join-Path $SCRIPT_DIR "create_project.tcl"
    
    # Append exit command to the Tcl script
    Add-Content -Path $createProjectScript -Value "exit"

    # Run Vivado in Tcl mode
    $vivadoArgs = @(
        "-mode", "tcl",
        "-source", $createProjectScript,
        "-journal", (Join-Path $VIVADO_OUTPUT_DIR "vivado_create_project.jou"),
        "-log", (Join-Path $VIVADO_OUTPUT_DIR "vivado_create_project.log")
    )

    # Execute Vivado
    & vivado $vivadoArgs
}

# Function to start Vivado in GUI mode
function start_vivado {
    $projectFile = Join-Path $VIVADO_OUTPUT_DIR "$PROJECT_NAME.xpr"
    
    if (Test-Path $projectFile) {
        $vivadoArgs = @(
            "-mode", "gui",
            "-journal", (Join-Path $VIVADO_OUTPUT_DIR "vivado.jou"),
            "-log", (Join-Path $VIVADO_OUTPUT_DIR "vivado.log"),
            $projectFile
        )

        # Start Vivado
        & vivado $vivadoArgs
    }
    else {
        Write-Error "Project file not found: $projectFile"
    }
}

# Function to clean the output directory
function clean {
    if (Test-Path $VIVADO_OUTPUT_DIR) {
        Remove-Item -Path (Join-Path $VIVADO_OUTPUT_DIR "*") -Recurse -Force
        Write-Host "Cleaned Vivado output directory: $VIVADO_OUTPUT_DIR"
    } 
    else {
        Write-Host "vivado_output directory doesn't exist, nothing cleaned"
    }
}

# Note: Functions are defined but not called
# To use this script, you would need to call the functions manually or create a menu system