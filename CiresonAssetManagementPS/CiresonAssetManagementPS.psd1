#
# Module manifest for module 'CiresonAssetManagementPS'
#
# Generated by: Francois-Xavier Cat
#
# Generated on: 2016-03-28
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'CiresonAssetManagementPS.psm1'

# Version number of this module.
ModuleVersion = '1.0.0'

# ID used to uniquely identify this module
GUID = '62c59d94-c707-4106-9029-488f5e7979da'

# Author of this module
Author = 'Francois-Xavier Cat'

# Company or vendor of this module
CompanyName = 'LazyWinAdmin.com'

# Copyright statement for this module
Copyright = '(c) 2016 Francois-Xavier Cat. All rights reserved. Licensed under The MIT License (MIT)'

# Description of the functionality provided by this module
Description = 'PowerShell module to manage Cireson Asset Management'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '3.0'

# Name of the Windows PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the Windows PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module
# CLRVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = "Smlets"

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module
FunctionsToExport = 'Get-CAMBase', 'Get-CAMCatalogItem', 'Get-CAMClass', 'Get-CAMConsumable', 'Get-CAMCostCenter', 'Get-CAMHardwareAsset', 'Get-CAMImportConnector', 'Get-CAMInvoice', 'Get-CAMLease', 'Get-CAMLicense', 'Get-CAMLocation', 'Get-CAMLog', 'Get-CAMMeteringData', 'Get-CAMNoticeEvent', 'Get-CAMNoticeEventData', 'Get-CAMOrganization', 'Get-CAMPurchase', 'Get-CAMPurchaseOrder', 'Get-CAMRelatedCustodian', 'Get-CAMRelatedObject', 'Get-CAMRelatedVendor', 'Get-CAMRelationshipObject', 'Get-CAMSetting', 'Get-CAMSoftwareAsset', 'Get-CAMStandard', 'Get-CAMSubnet', 'Get-CAMSupportContract', 'Get-CAMVendor', 'Get-CAMWarranty', 'New-CAMObject', 'New-CAMVendor'

# Cmdlets to export from this module
# CmdletsToExport = '*'

# Variables to export from this module
# VariablesToExport = '*'

# Aliases to export from this module
# AliasesToExport = '*'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = 'Cireson','CAM','CiresonAssetManagement','SCSM','ServiceManager','SystemCenter'

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/lazywinadmin/CiresonAssetManagementPS/blob/master/LICENSE.md'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/lazywinadmin/CiresonAssetManagementPS'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

