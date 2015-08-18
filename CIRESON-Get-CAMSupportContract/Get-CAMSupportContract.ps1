function Get-CAMSupportContract
{
<#
	.SYNOPSIS
		Function to retrieve Support Contract from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve Support Contract from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID of the contract. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply
	
	.PARAMETER DaysLeft
		Specifies the days before expiration of the contract

	.EXAMPLE
		Get-CAMSupportContract
		
		Retrieve all the contract
	
	.EXAMPLE
		Get-CAMSupportContract -DisplayName "Dell*"
		
		Retrieve the contracts Display Name starting by Dell
	
	.EXAMPLE
		Get-CAMSupportContract -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific Contract with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'
	
	.EXAMPLE
		Get-CAMSupportContract -DaysLeft 30
		
		Retrieve contracts expiring in the next 30 days
	
	.EXAMPLE
		Get-CAMSupportContract -Expired
		
		Retrieve all the expired contracts
	
	.NOTES
		Additional information about the function.
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		[System.String]$Filter,
		
		[Parameter(ParameterSetName = 'ExpirationDays')]
		[Int]$DaysLeft
		
		<#[Parameter(ParameterSetName = 'Status')]
		#[ValidateSet('OK','Warning', 'Expired')]
		[Cireson.AssetManagement.ContractS]$Status,#>
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
				Class = (get-scsmclass -name 'Cireson.AssetManagement.SupportContract')
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