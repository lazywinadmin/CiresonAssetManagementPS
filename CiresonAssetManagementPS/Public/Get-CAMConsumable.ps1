function Get-CAMConsumable
{
<#
.SYNOPSIS
	Function to retrieve Consumable from the Cireson Asset Management
.DESCRIPTION
	Function to retrieve Consumable from the Cireson Asset Management
.PARAMETER DisplayName
	Specifies the Displayname
.PARAMETER Id
	Specifies the ID
.EXAMPLE
	Get-CAMConsumable
.EXAMPLE
	Get-CAMConsumable -DisplayName "*Pro" 
.EXAMPLE
	Get-CAMConsumable -id '3cbgg558-a09c-b717-2401-05aef430b01f'
.NOTES
	Francois-Xavier Cat
	www.lazywinadmin.com
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
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Consumable') -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: ID"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Consumable') -Filter "Id -eq $ID"
			}
			ELSE
			{
				Write-Verbose -Message "[PROCESS] No Parameter specified, retrieving all"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Consumable')
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Hardware Assets"
			$Error[0].Exception.Message
		}
	}
}
