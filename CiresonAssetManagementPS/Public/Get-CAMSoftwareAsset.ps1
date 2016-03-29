function Get-CAMSoftwareAsset
{
	<#
	.SYNOPSIS
		Function to retrieve Software Asset from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Software Asset from the Cireson Asset Management
	.EXAMPLE
		Get-CamSoftwareAsset
	.EXAMPLE
		Get-CamSoftwareAsset -DisplayName "*Pro" 
	.EXAMPLE
		Get-CamSoftwareAsset -id '3cbgg558-a09c-b717-2401-05aef430b01f'
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
	#>
	[CmdletBinding(DefaultParameterSetName = 'All')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
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
				Class = (get-scsmclass -name 'Cireson.AssetManagement.SoftwareAsset')
			}
			
			IF ($PSBoundParameters['DisplayName']) { get-scsmobject @Splatting -Filter "DisplayName -like $DisplayName" }
			ELSEIF ($PSBoundParameters['ID']) { get-scsmobject @Splatting -Filter "Id -eq $ID" }
			ELSE { get-scsmobject @Splatting }
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Software Assets"
			$Error[0].Exception.Message
		}
	}
}