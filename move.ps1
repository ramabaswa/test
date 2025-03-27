Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Mouse {
        [DllImport("user32.dll")]
        public static extern bool SetCursorPos(int x, int y);
    }
"@

function Start-AntiscreenSaver {
    # Save the current execution policy
    $currentPolicy = Get-ExecutionPolicy
    # Set the execution policy to RemoteSigned
    Set-ExecutionPolicy RemoteSigned -Scope Process

    $screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height
    $screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width

    $targetX = $screenWidth / 2
    $targetY = $screenHeight

    $timeout = New-TimeSpan -Minutes 5

    while ($true) {
        $currentTime = Get-Date -Format "HH:mm:ss"
        $randomMinute = Get-Random -Minimum 49 -Maximum 59
        $currentMousePosition = [System.Windows.Forms.Cursor]::Position.X
        Start-Sleep -Milliseconds 10000
        if (($currentTime -gt ("07:"+$30+":30")) -and 
           ($currentTime -le ("16:"+$randomMinute+":00"))
           ){
            Start-MoveIfSamePosition($currentMousePosition)
            
            # Reset lastInputTime
            $lastInputTime = [Environment]::TickCount
        }
        
        # Check input interval
        Start-Sleep -Milliseconds 1000
    }

    # Set the execution policy back to the original value
    Set-ExecutionPolicy $currentPolicy -Scope Process
}


Function Start-MoveIfSamePosition {
[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$currentMousePosition
)
    $newMousePosition = [System.Windows.Forms.Cursor]::Position.X
    if($newMousePosition -eq $currentMousePosition){
        Write-Host $newMousePosition
        Write-Host $currentMousePosition
        # move the mouse cursor
        [Mouse]::SetCursorPos($targetX+10, $targetY+10)
        Start-Sleep -Seconds 1
        [Mouse]::SetCursorPos($targetX+50, $targetY+50)
    }
}

Start-AntiscreenSaver