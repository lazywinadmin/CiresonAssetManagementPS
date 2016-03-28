function Get-CAMOrganization
{
	<#
	.SYNOPSIS
		Function to retrieve Organization from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Organization from the Cireson Asset Management
	.EXAMPLE
		Get-CamOrganization
	.EXAMPLE
		Get-CamOrganization -Displayname 'IT'
	.EXAMPLE
		Get-CamOrganization -ID '80e80889-86d1-4cee-b1e9-fcd265fa54a2'
	.EXAMPLE
		Get-CamOrganization -Filter "ID -eq 80e80889-86d1-4cee-b1e9-fcd265fa54a2"
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
	#>
	[CmdletBinding(DefaultParameterSetName = 'All')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		$Filter
	)
	BEGIN
	{
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Debug -Message "ParameterSetName: $($PSCmdlet.ParameterSetName)"
		Write-Debug -Message "Parameters: $($PSBoundParameters.Keys)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				class = get-scsmclass -name 'Cireson.AssetManagement.Organization'
			}
			
			IF ($PSBoundParameters['DisplayName']) { get-scsmobject -class @Splatting -Filter "DisplayName -like $DisplayName" }
			ELSEIF ($PSBoundParameters['ID']) { get-scsmobject -class @Splatting -Filter "Id -eq $ID" }
			ELSEIF ($PSBoundParameters['Filter']) { get-scsmobject -class @Splatting -Filter $Filter }
			ELSE { Get-SCSMObject @Splatting }
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}