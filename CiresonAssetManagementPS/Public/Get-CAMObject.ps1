Function New-CAMObject
{
<#
	.SYNOPSIS
		Function to retrieving Cireson Asset Management Object(s)
	
	.DESCRIPTION
		Function to retrieving Cireson Asset Management Object(s)
	
    .PARAMETER TypeName
        Specifies the type of Object you want to create
        
    .PARAMETER Filter  
        Specifies the Filter to apply on the query
    
	.EXAMPLE
        Get-CAMObject -TypeName Vendor

    .EXAMPLE
        Get-CAMObject -TypeName Vendor -filter "Name -eq 'Google'"   
	
	.NOTES
		Francois-Xavier Cat
		lazywinadmin.com
		@lazywinadm
		github.com/lazywinadmin
#>
	[CmdletBinding()]
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
		[Parameter()]
        $Filter
	)
    TRY
    {
        Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message 'Creating Splatting')
        Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message "Querying Class: Cireson.AssetManagement.$TypeName")
        $Splatting = @{
            Class = (get-scsmclass -name "Cireson.AssetManagement.$TypeName")
        }
        
        IF($PSBoundParameters['Filter'])
        {
            Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message 'Filter Specified: $Filter')
            $Splatting.Filter = $Filter
        }
        
        # Get CAM object
        Write-Verbose -Message $(New-ScriptMessage -Block PROCESS -message 'Retrieving objects...')
        Get-SCSMObject @Splatting
    }
    CATCH
    {
        Write-Error -Message "[PROCESS] An Error occured"
        $Error[0].Exception.Message
    }
}