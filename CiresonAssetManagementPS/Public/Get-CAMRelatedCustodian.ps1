Function Get-CAMRelatedCustodian
{
<#
.SYNOPSIS
	Function to retrieve the Related Custodian of an object

.DESCRIPTION
	Function to retrieve the Related Custodian of an object

.PARAMETER WorkItemObject
	Specifies the Object to process

.EXAMPLE
	PS C:\> Get-CAMRelatedCustodian -WorkItemObject $SupportContract

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
	# Custodian RelationShip
	$OwnedByUser_relclass_id = 'cbb45424-b0a2-72f0-d535-541941cdf8e1'
	$OwnedByUser_relclass_obj = Get-SCSMRelationshipClass -id $OwnedByUser_relclass_id
	Get-SCSMRelatedObject -SMObject $WorkItemObject -Relationship $OwnedByUser_relclass_obj
}