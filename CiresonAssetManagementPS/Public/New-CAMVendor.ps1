﻿Function New-CAMVendor
{
<#
.SYNOPSIS
	Function to create a new Cireson Asset Management Vendor

.DESCRIPTION
	Function to create a new Cireson Asset Management Vendor

.PARAMETER Name
	Specify the name of the Vendor(s)
	
.PARAMETER Hashtable
	Specifies multiple properties of the new vendor.

.EXAMPLE
	PS C:\> New-CAMVendor -Name "VMware"

.EXAMPLE
	PS C:\> New-CAMVendor -Name "VMware", "Microsoft", "Google"

.EXAMPLE
	Get-Content Vendors.txt | New-CAMVendor
	
.EXAMPLE
	$props = @{
		Name = "Google"
		Website = "www.Google.com"
		VendorAddress1 = "San Francisco"
	}		
	
	New-CAMVendor -hashtable $props

.NOTES
	Francois-Xavier Cat
	lazywinadmin.com
	@lazywinadm
	github.com/lazywinadmin
#>
	[CmdletBinding(SupportsShouldProcess=$true,DefaultParameterSetName='Name')]
	PARAM (
		[Parameter(Mandatory,ValueFromPipeline,ParameterSetName='Name')]
		[String[]]$Name,
		[Parameter(Mandatory,ParameterSetName='Name')]
		[Hashtable]$HashTable
	)
	
	FOREACH ($Item in $Name)
	{
		TRY
		{
			IF ($PSBoundParameters['Name'])
			{
			
				# Define the Properties
				$properties = @{
					Name = $Item
				}
			}
			
			IF ($PSBoundParameters['Hashtable'])
			{
				$properties = $HashTable
			}
			
			if ($PSCmdlet.ShouldProcess($properties,"Create an object of Type (Cireson.AssetManagement.Vendor)"))
        	{
				# Create the Item
				New-SCSMObject -Class (get-scsmclass -name 'Cireson.AssetManagement.Vendor') -PropertyHashtable $properties
			}
		}
		CATCH
		{
			
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}

#get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Vendor') | fl *
#(get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Vendor')).values

<#
EXAMPLE OF OUTUT

Name                                         : VMWare
VendorAddress1                               : Parnel House, Barrack Square
VendorAddress2                               : Main St
VendorCity                                   : Ballincollig
VendorState                                  : Co, Cork
VendorPostCode                               : 
VendorCountry                                : Ireland
VendorContact                                : Lauren 
VendorEmail                                  : r@wmware.com
VendorPhone                                  : +
VendorFax                                    : 
WebSite                                      : www.vmware.com
ObjectStatus                                 : Active
AssetStatus                                  : 
Notes                                        : 
DisplayName                                  : VMWare
ClassName                                    : Cireson.AssetManagement.Vendor
LastModified                                 : 8/3/2015 2:18:21 PM
TypeName                                     : Cireson.AssetManagement.Vendor
Path                                         : 
FullName                                     : Cireson.AssetManagement.Vendor:VMWare
ManagementPackClassIds                       : {f26c94f2-1045-3d60-4c1f-59b8cbfe9931}
LeastDerivedNonAbstractManagementPackClassId : f26c94f2-1045-3d60-4c1f-59b8cbfe9931
TimeAdded                                    : 8/3/2015 6:18:21 PM
LastModifiedBy                               : 7431e155-3d9e-4724-895e-c03ba951a352
Values                                       : {VMWare, Parnel House, Barrack Square, Main St, Ballincollig...}
IsNew                                        : False
HasChanges                                   : False
Id                                           : d85104a5-bc3a-f629-84ef-15f41d21a798
ManagementGroup                              : SCSM WB Games Montreal
ManagementGroupId                            : 0ddb97c1-4a81-3958-ad92-26cb0457c075
GroupsAsDifferentType                        : False
ViewName                                     : ManagedEntityGenericView
ObjectMode                                   : All

#>