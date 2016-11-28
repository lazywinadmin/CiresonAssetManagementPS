function Get-CAMBase
{
<#
.SYNOPSIS
	Function to retrieve Base from the Cireson Asset Management
.DESCRIPTION
	Function to retrieve Base from the Cireson Asset Management
.PARAMETER DisplayName
	Specifies the Displayname
.PARAMETER Id
	Specifies the ID
.EXAMPLE
	Get-CAMBase
.EXAMPLE
	Get-CAMBase -DisplayName "*Pro" 
.EXAMPLE
	Get-CAMBase -id '3cbgg558-a09c-b717-2401-05aef430b01f'
.NOTES
	Francois-Xavier Cat
	lazywinadmin.com
	@Lazywinadm
	github.com/lazywinadmin
#>
	[CmdletBinding(DefaultParameterSetName = 'DisplayName')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id
	)
	BEGIN
	{
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
	}
	PROCESS
	{
		TRY
		{
			IF ($PSBoundParameters['DisplayName'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: DisplayName"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Base') -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: ID"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Base') -Filter "Id -eq $ID"
			}
			ELSE
			{
				Write-Verbose -Message "[PROCESS] No Parameter specified, retrieving all"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Base')
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Hardware Assets"
			$Error[0].Exception.Message
		}
	}
}
