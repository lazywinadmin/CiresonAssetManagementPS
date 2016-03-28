function Get-CAMVendor
{
<#
	.SYNOPSIS
		Function to retrieve Vendor from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve Vendor from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply
	
	.EXAMPLE
		Get-CAMVendor
		
		Retrieve all the Vendor
	
	.EXAMPLE
		Get-CAMVendor -DisplayName "Insight*"
		
		Retrieve the Vendor Display Name starting by Insight
	
	.EXAMPLE
		Get-CAMVendor -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific Vendor with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		[System.String]$Filter
	)
	
	BEGIN
	{
		
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Verbose "[BEGIN] ParameterSet: $($PSCmdlet.ParameterSetName)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				Class = (get-scsmclass -name 'Cireson.AssetManagement.Vendor')
			}
			
			IF ($PSBoundParameters['DisplayName'])
			{
				Get-Scsmobject @Splatting -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Get-Scsmobject @Splatting -Filter "Id -eq $ID"
			}
			ELSEIF ($PSBoundParameters['Filter'])
			{
				get-scsmobject @Splatting -Filter $Filter
			}
			ELSE
			{
				get-scsmobject @Splatting
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}