# CiresonAssetManagementPS

This PowerShell module allows you to manage the Cireson Asset Management (CAM) solution.
CAM is plug-in attached to the System Center Service Manager (SCSM) plateform. 

This module is relying on the SMlets PowerShell module which allows you to manage SCSM.

## Requirements
 * Smlet PowerShell module
  * [Download the Smlets module](https://smlets.codeplex.com/)
  * [Installation/Configuration](http://www.lazywinadmin.com/2014/09/powershell-scsm-install-and-config.html)

## Installation
#### Download from PowerShell Gallery
``` powershell
Install-Module CiresonAssetManagementPS
```
#### Download from GitHub repository

* Download the repository
* Unblock the zip file
* Extract the folder CiresonAssetManagementPS to a module path (e.g. $home\Documents\WindowsPowerShell\Modules)

## Getting Started

``` powershell
# Load the module into your session
Import-Module CiresonAssetManagementPS

# Retrieve all Hardware Assets
Get-CAMHardwareAsset

# Retrieve related object to a specific Asset
$hw = Get-CamHardwareAsset -DisplayName "TestPC" 
Get-CAMRelatedObject -WorkItem $hw

# Retrieve relationship objects to a specific Asset
$hw = Get-CamHardwareAsset -DisplayName "TestPC" 
Get-CAMRelationshipObject -BySource $hw

# Retrieve Support Contract
Get-CAMSupportContract -DisplayName "HP Workstation 2016"

# Retrieve the custodian of a Support Contract
$HPContract = Get-CAMSupportContract -DisplayName "HP Workstation 2016"
Get-CAMRelatedCustodian -WorkItemObject $HPContract

# New Support Contract
$props = @{
    Name = "HP Servers 2016"
}
New-CAMObject -HashTable $props -TypeName SupportContract

# Create a new Vendor
$props = @{
    Name = "LazyWinAdmin"
    Website = "www.LazyWinAdmin.com"
    VendorAddress1 = "Montreal"
}	
New-CAMVendor -hashtable $props
```


## Cmdlets

``` powershell
# Retrieving all the Cmdlets available
Get-Command -module CiresonAssetManagementPS
```

* Get-CAMBase
* Get-CAMCatalogItem
* Get-CAMClass
* Get-CAMConsumable
* Get-CAMCostCenter
* Get-CAMHardwareAsset
* Get-CAMImportConnector
* Get-CAMInvoice
* Get-CAMLease
* Get-CAMLicense
* Get-CAMLocation
* Get-CAMLog
* Get-CAMMeteringData
* Get-CAMNoticeEvent
* Get-CAMNoticeEventData
* Get-CAMOrganization
* Get-CAMPurchase
* Get-CAMPurchaseOrder
* Get-CAMRelatedCustodian
* Get-CAMRelatedObject
* Get-CAMRelatedVendor
* Get-CAMRelationshipObject
* Get-CAMSettings
* Get-CAMSoftwareAsset
* Get-CAMStandard
* Get-CAMSubnet
* Get-CAMSupportContract
* Get-CAMVendor
* Get-CAMWarranty
* New-CAMVendor
