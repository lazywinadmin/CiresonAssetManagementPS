#get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Vendor') | fl *
#(get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.Vendor')).values

<#
Name                                         : VMWare
VendorAddress1                               : Parnel House, Barrack Square
VendorAddress2                               : Main St
VendorCity                                   : Ballincollig
VendorState                                  : Co, Cork
VendorPostCode                               : 
VendorCountry                                : Ireland
VendorContact                                : Lauren Berquist
VendorEmail                                  : ar@wmware.com
VendorPhone                                  : +353-21-4660000
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

Function New-CAMVendor
{
	PARAM($Name)
	
	$properties = @{
		Name = $Name
	}
	New-SCSMObject -Class (get-scsmclass -name 'Cireson.AssetManagement.Vendor') -PropertyHashtable $properties
}