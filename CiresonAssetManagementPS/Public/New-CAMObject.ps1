Function New-CAMObject
{
<#
.SYNOPSIS
    Function to create a new Cireson Asset Management Object

.DESCRIPTION
    Function to create a new Cireson Asset Management Object

.PARAMETER TypeName
    Specifies the type of Object you want to create

.PARAMETER Hashtable    
    Specifies the properties of the new object
    
.EXAMPLE
    $props = @{
        Name = "Google"
        Website = "www.Google.com"
        VendorAddress1 = "San Francisco"
    }		
    
    New-CAMObject -TypeName Vendor -hashtable $props

.NOTES
    Francois-Xavier Cat
    lazywinadmin.com
    @lazywinadm
    github.com/lazywinadmin
#>
	[CmdletBinding(SupportsShouldProcess=$true)]
	PARAM (
		[Parameter(Mandatory)]
        [ValidateSet(
            "Base",
            "CatalogItem",
            "Consumable",
            "CostCenter",
            "HardwareAsset",
            "Import.Connector",
            "Invoice",
            "Lease",
            "License",
            "Location",
            "Log",
            "MeteringData",
            "NoticeEvent",
            "NoticeEventData",
            "Organization",
            "Purchase",
            "PurchaseOrder",
            "Settings",
            "SoftwareAsset",
            "Standard",
            "Subnet",
            "SupportContract",
            "Vendor",
            "Warranty"
            )]
        [String]$TypeName,
		[Parameter(Mandatory)]
        [ValidateScript({
            [bool]$($_.name)
        })]
		[Hashtable]$HashTable
	)
    TRY
    {
        if ($PSCmdlet.ShouldProcess($HashTable,"Create an object of Type ($TypeName)"))
        {
            Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message "TypeName Cireson.AssetManagement.$TypeName")
            
            # Create the Item
            New-SCSMObject -Class (get-scsmclass -name "Cireson.AssetManagement.$TypeName") -PropertyHashtable $HashTable
            
            Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message "Object Created")
        }
    }
    CATCH
    {
        Write-Error -Message "[PROCESS] An Error occured"
        $Error[0].Exception.Message
    }
}