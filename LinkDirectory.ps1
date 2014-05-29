# Link this directory as RCT2's 'Saved Games' directory
# Run as administrator

Import-Module Pscx

$destDir = "${env:ProgramFiles(x86)}\GOGcom\RollerCoaster Tycoon 2 Triple Thrill Pack\Saved Games"

$confirmation = Read-Host -Prompt "Warning: This will destroy your current RCT2 'Saved Games' directory ($destDir).`nPlease confirm that you understand this by entering 'yes' at the prompt"

If ($confirmation -ne 'yes') {
	Write-Host 'Aborted'
	Return
}

Remove-Item -Recurse $destDir
New-Symlink -LiteralPath $destDir -TargetPath .