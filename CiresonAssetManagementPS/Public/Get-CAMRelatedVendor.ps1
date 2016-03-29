Function Get-CAMRelatedVendor
{
<#
	.SYNOPSIS
		Function to retrieve the Vendor associate with a specific CAM class
	
	.DESCRIPTION
		Function to retrieve the Vendor associate with a specific CAM class.
		I'm using this for Support Contracts.
	
	.PARAMETER WorkItemObject
		Specify the Object
	
	.EXAMPLE
		PS C:\> Get-CAMRelatedVendor -WorkItemObject $SupportContract
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
		github.com/lazywinadmin
#>
	[CmdletBinding()]
	PARAM (
		[Parameter(ValueFromPipeline)]
		$WorkItemObject
	)
	
	# Vendor RelationShip
	$Vendor_relclass_id = '74a61725-6305-bdd4-327a-fd49e1ccf993'
	$Vendor_relclass_obj = Get-SCSMRelationshipClass -id $Vendor_relclass_id
	Get-SCSMRelatedObject -SMObject $WorkItemObject -Relationship $Vendor_relclass_obj
}