# Link this directory as RCT2's 'Saved Games' directory
# Run from project root directory

[CmdletBinding()]
Param(
	[Parameter(Mandatory=$true, Position=1)]
	[string]$rct2RootPath
)

Import-Module Pscx

$destDir = Resolve-Path -Path "$rct2RootPath\Saved Games"

# For linking the files, we can use symbolic links or hard links. Symbolic links require administrator permission (for some reason) but hard links do not. Hard links do not work across filesystem boundaries. Therefore, we'll use hard links if we don't need to cross a filesystem boundary.
$needsSymlink = (Split-Path -Qualifier $destDir) -ne (Split-Path -Qualifier (Get-Location))

$confirmation = Read-Host -Prompt "Warning: This will destroy your current RCT2 'Saved Games' directory ($destDir).`nPlease confirm that you understand this by entering 'yes' at the prompt"

If ($confirmation -ne 'yes') {
	Write-Host 'Aborted'
	Return
}

Remove-Item -Recurse $destDir
If ($needsSymlink) {
	New-Symlink -LiteralPath $destDir -TargetPath .
}
Else {
	New-Junction -LiteralPath $destDir -TargetPath .
}