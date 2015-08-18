function Get-CAMLicense
{
<#
	.SYNOPSIS
		Function to retrieve License from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve License from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID of the License. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply

	.EXAMPLE
		Get-CAMLicense
		
		Retrieve all the Licenses
	
	.EXAMPLE
		Get-CAMLicense -DisplayName "Antidote*"
		
		Retrieve the Licenses with the displayname Antidote
	
	.EXAMPLE
		Get-CAMLicense -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific License with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'

	.EXAMPLE
		Get-CAMLicense -filter "SeatsRemaining -gt 1"
		
		Retrieve Licenses with more thant 1 seat available
	
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
				Class = (Get-SCSMClass -name 'Cireson.AssetManagement.Licence')
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
			ELSEIF ($PSBoundParameters['DaysLeft'])
			{
				get-scsmobject @Splatting -Filter "ContractEndDate -lt $((Get-Date).AddDays($DaysLeft))" #-and ContractEndDate -ge $(Get-Date)"
			}
			ELSE
			{
				get-scsmobject @Splatting
			}
			<#IF ($PSBoundParameters['Status'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: Status"
				get-scsmobject @Splatting -Filter "ContractStatus -eq $Status"
			}#>
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}