Function Get-CAMRelationshipObject
{
<#
	.SYNOPSIS
		Function to retrieve the relationship object(s) of an Object
	
	.DESCRIPTION
		Function to retrieve the relationship object(s) of an Object
	
	.PARAMETER BySource
		Specifies the Object to process
		
  .EXAMPLE
    $HardwareAssetPCpro = Get-CamHardwareAsset -DisplayName "PCPro"
		Get-CAMRelationshipObject -BySource $HardwareAssetPCpro
		
		This will retrieve all the relationship objects to the Hardware Asset "PCPro"
	
	.EXAMPLE
	  $SupportContract = Get-CAMSupportContract -DisplayName "Dell Servers 2016"
		Get-CAMRelationshipObject -BySource $SupportContract
		
		This will retrieve all the relationship objects to the Support Contract "Dell Servers 2016"
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
		github.com/lazywinadmin
#>
	[CmdletBinding()]
	param (
		[Parameter(ValueFromPipeline)]
		[Alias('WorkItemObject')]
		$BySource
	)
	Get-SCSMRelationshipObject -BySource $WorkItemObject
}
