Function Get-CAMRelatedObject
{
<#
	.SYNOPSIS
		Function to retrieve the Related Object
	
	.DESCRIPTION
		Function to retrieve the Related Object
	
	.PARAMETER WorkItemObject
		Specifies the Object to process
		
  .EXAMPLE
    $HardwareAssetPCpro = Get-CamHardwareAsset -DisplayName "PCPro"
		Get-CAMRelatedObject -WorkItemObject $HardwareAssetPCpro
		
		This will retrieve all the related object to the Hardware Asset "PCPro"
	
	.EXAMPLE
	  $SupportContract = Get-CAMSupportContract -DisplayName "Dell Servers 2016"
		Get-CAMRelatedObject -WorkItemObject $SupportContract
		
		This will retrieve all the related object to the Support Contract "Dell Servers 2016"
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
		github.com/lazywinadmin
#>
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline)]
		$WorkItemObject
	)
	Get-SCSMRelatedObject -SMObject $WorkItemObject
}
