﻿function Get-CAMHardwareAsset
{
	<#
	.SYNOPSIS
		Function to retrieve Hardware Asset from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Hardware Asset from the Cireson Asset Management
	.EXAMPLE
		Get-CamHardwareAsset
	.EXAMPLE
		Get-CamHardwareAsset -DisplayName "*Pro" 
	.EXAMPLE
		Get-CamHardwareAsset -id '3cbgg558-a09c-b717-2401-05aef430b01f'
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
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
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset') -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: ID"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset') -Filter "Id -eq $ID"
			}
			ELSE
			{
				Write-Verbose -Message "[PROCESS] No Parameter specified, retrieving all"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset')
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Hardware Assets"
			$Error[0].Exception.Message
		}
	}
}