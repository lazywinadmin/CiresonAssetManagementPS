function Get-CAMClass
{
	<#
	.SYNOPSIS
		Function to retrieve Cireson Asset Management classes
	.DESCRIPTION
		Function to retrieve Cireson Asset Management classes
	.EXAMPLE
		Get-CAMClass
	.EXAMPLE
	
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
	#>
	PARAM
	(
	<#
		[Parameter(ValueFromPipelineByPropertyName = $true,
				   ValueFromPipeline = $true)]
		[Alias("Computer","__SERVER","CN")]
		[String[]]$ComputerName,
		
		[Alias("RunAs")]
		[System.Management.Automation.Credential()]
		$Credential = [System.Management.Automation.PSCredential]::Empty,
	
		$Name
	#>
	)
	Get-ScsmClass -name 'Cireson.AssetManagement.*'
}

function Get-CAMHardwareAsset
{
	<#
	.SYNOPSIS
		Function to retrieve Hardware Asset from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Hardware Asset from the Cireson Asset Management
	.EXAMPLE
		Get-CamHardwareAsset
	.EXAMPLE
		Get-CamHardwareAsset -DisplayName "*Pro" 
	.EXAMPLE
		Get-CamHardwareAsset -id '3cbgg558-a09c-b717-2401-05aef430b01f'
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
	#>
	[CmdletBinding(DefaultParameterSetName = 'DisplayName')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id
	)
	BEGIN
	{
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
	}
	PROCESS
	{
		TRY
		{
			IF ($PSBoundParameters['DisplayName'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: DisplayName"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset') -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: ID"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset') -Filter "Id -eq $ID"
			}
			ELSE
			{
				Write-Verbose -Message "[PROCESS] No Parameter specified, retrieving all"
				get-scsmobject -class (get-scsmclass -name 'Cireson.AssetManagement.HardwareAsset')
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Hardware Assets"
			$Error[0].Exception.Message
		}
	}
}

function Get-CAMLicense
{
<#
	.SYNOPSIS
		Function to retrieve License from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve License from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID of the License. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply

	.EXAMPLE
		Get-CAMLicense
		
		Retrieve all the Licenses
	
	.EXAMPLE
		Get-CAMLicense -DisplayName "Antidote*"
		
		Retrieve the Licenses with the displayname Antidote
	
	.EXAMPLE
		Get-CAMLicense -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific License with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'

	.EXAMPLE
		Get-CAMLicense -filter "SeatsRemaining -gt 1"
		
		Retrieve Licenses with more thant 1 seat available
	
	.NOTES
		Francois-Xavier Cat
        www.lazywinadmin.com
        @lazywinadm
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		[System.String]$Filter
	)
	
	BEGIN
	{
		
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Debug -Message "ParameterSetName: $($PSCmdlet.ParameterSetName)"
		Write-Debug -Message "Parameters: $($PSBoundParameters.Keys)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				Class = (Get-SCSMClass -name 'Cireson.AssetManagement.Licence')
			}
			
			IF ($PSBoundParameters['DisplayName']){Get-Scsmobject @Splatting -Filter "DisplayName -like $DisplayName"}
			ELSEIF ($PSBoundParameters['ID']){Get-Scsmobject @Splatting -Filter "Id -eq $ID"}
			ELSEIF ($PSBoundParameters['Filter']){get-scsmobject @Splatting -Filter $Filter}
			ELSEIF ($PSBoundParameters['DaysLeft'])
			{
				get-scsmobject @Splatting -Filter "ContractEndDate -lt $((Get-Date).AddDays($DaysLeft))" #-and ContractEndDate -ge $(Get-Date)"
			}
			ELSE{get-scsmobject @Splatting}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}

function Get-CAMOrganization
{
	<#
	.SYNOPSIS
		Function to retrieve Organization from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Organization from the Cireson Asset Management
	.EXAMPLE
		Get-CamOrganization
	.EXAMPLE
		Get-CamOrganization -Displayname 'IT'
	.EXAMPLE
		Get-CamOrganization -ID '80e80889-86d1-4cee-b1e9-fcd265fa54a2'
	.EXAMPLE
		Get-CamOrganization -Filter "ID -eq 80e80889-86d1-4cee-b1e9-fcd265fa54a2"
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
	#>
	[CmdletBinding(DefaultParameterSetName = 'All')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		$Filter
	)
	BEGIN
	{
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Debug -Message "ParameterSetName: $($PSCmdlet.ParameterSetName)"
		Write-Debug -Message "Parameters: $($PSBoundParameters.Keys)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				class = get-scsmclass -name 'Cireson.AssetManagement.Organization'
			}
			
			IF ($PSBoundParameters['DisplayName']) { get-scsmobject -class @Splatting -Filter "DisplayName -like $DisplayName" }
			ELSEIF ($PSBoundParameters['ID']) { get-scsmobject -class @Splatting -Filter "Id -eq $ID" }
			ELSEIF ($PSBoundParameters['Filter']) { get-scsmobject -class @Splatting -Filter $Filter }
			ELSE { Get-SCSMObject @Splatting }
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}

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

function Get-CAMSoftwareAsset
{
	<#
	.SYNOPSIS
		Function to retrieve Software Asset from the Cireson Asset Management
	.DESCRIPTION
		Function to retrieve Software Asset from the Cireson Asset Management
	.EXAMPLE
		Get-CamSoftwareAsset
	.EXAMPLE
		Get-CamSoftwareAsset -DisplayName "*Pro" 
	.EXAMPLE
		Get-CamSoftwareAsset -id '3cbgg558-a09c-b717-2401-05aef430b01f'
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
	#>
	[CmdletBinding(DefaultParameterSetName = 'All')]
	PARAM (
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		$Filter
	)
	BEGIN
	{
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		Write-Debug -Message "ParameterSetName: $($PSCmdlet.ParameterSetName)"
		Write-Debug -Message "Parameters: $($PSBoundParameters.Keys)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				Class = (get-scsmclass -name 'Cireson.AssetManagement.SoftwareAsset')
			}
			
			IF ($PSBoundParameters['DisplayName']) { get-scsmobject @Splatting -Filter "DisplayName -like $DisplayName" }
			ELSEIF ($PSBoundParameters['ID']) { get-scsmobject @Splatting -Filter "Id -eq $ID" }
			ELSE { get-scsmobject @Splatting }
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured while querying Software Assets"
			$Error[0].Exception.Message
		}
	}
}

function Get-CAMSupportContract
{
<#
	.SYNOPSIS
		Function to retrieve Support Contract from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve Support Contract from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID of the contract. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply
	
	.PARAMETER DaysLeft
		Specifies the days before expiration of the contract

	.EXAMPLE
		Get-CAMSupportContract
		
		Retrieve all the contract
	
	.EXAMPLE
		Get-CAMSupportContract -DisplayName "Dell*"
		
		Retrieve the contracts Display Name starting by Dell
	
	.EXAMPLE
		Get-CAMSupportContract -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific Contract with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'
	
	.EXAMPLE
		Get-CAMSupportContract -DaysLeft 30
		
		Retrieve contracts expiring in the next 30 days
	
	.EXAMPLE
		Get-CAMSupportContract -Expired
		
		Retrieve all the expired contracts
	
	.NOTES
		Additional information about the function.
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		[System.String]$Filter,
		
		[Parameter(ParameterSetName = 'ExpirationDays')]
		[Int]$DaysLeft
		
		<#[Parameter(ParameterSetName = 'Status')]
		#[ValidateSet('OK','Warning', 'Expired')]
		[Cireson.AssetManagement.ContractS]$Status,#>
	)
	
	BEGIN
	{
		
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Verbose "[BEGIN] ParameterSet: $($PSCmdlet.ParameterSetName)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				Class = (get-scsmclass -name 'Cireson.AssetManagement.SupportContract')
			}
			
			IF ($PSBoundParameters['DisplayName'])
			{
				Get-Scsmobject @Splatting -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Get-Scsmobject @Splatting -Filter "Id -eq $ID"
			}
			ELSEIF ($PSBoundParameters['Filter'])
			{
				get-scsmobject @Splatting -Filter $Filter
			}
			ELSEIF ($PSBoundParameters['DaysLeft'])
			{
				get-scsmobject @Splatting -Filter "ContractEndDate -lt $((Get-Date).AddDays($DaysLeft))" #-and ContractEndDate -ge $(Get-Date)"
			}
			ELSE
			{
				get-scsmobject @Splatting
			}
			<#IF ($PSBoundParameters['Status'])
			{
				Write-Verbose -Message "[PROCESS] Parameter: Status"
				get-scsmobject @Splatting -Filter "ContractStatus -eq $Status"
			}#>
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}

function Get-CAMVendor
{
<#
	.SYNOPSIS
		Function to retrieve Vendor from the Cireson Asset Management
	
	.DESCRIPTION
		Function to retrieve Vendor from the Cireson Asset Management
	
	.PARAMETER DisplayName
		Specifies the DisplayName
	
	.PARAMETER ID
		Specifies the ID. Typically the GUID.
	
	.PARAMETER Filter
		Specifies the filter you want to apply
	
	.EXAMPLE
		Get-CAMVendor
		
		Retrieve all the Vendor
	
	.EXAMPLE
		Get-CAMVendor -DisplayName "Insight*"
		
		Retrieve the Vendor Display Name starting by Insight
	
	.EXAMPLE
		Get-CAMVendor -id '3cbgg558-a09c-b717-2401-05aef430b01f'
		
		Retrieve the specific Vendor with the ID '3cbgg558-a09c-b717-2401-05aef430b01f'
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
#>
	
	[CmdletBinding(DefaultParameterSetName = 'All')]
	param
	(
		[Parameter(ParameterSetName = 'DisplayName')]
		[System.String]$DisplayName,
		
		[Parameter(ParameterSetName = 'ID')]
		$Id,
		
		[Parameter(ParameterSetName = 'Filter')]
		[System.String]$Filter
	)
	
	BEGIN
	{
		
		if (-not (Get-Module -Name SMLets)) { Import-Module -Name SMLets -ErrorAction Stop }
		
		Write-Verbose "[BEGIN] ParameterSet: $($PSCmdlet.ParameterSetName)"
	}
	PROCESS
	{
		TRY
		{
			$Splatting = @{
				Class = (get-scsmclass -name 'Cireson.AssetManagement.Vendor')
			}
			
			IF ($PSBoundParameters['DisplayName'])
			{
				Get-Scsmobject @Splatting -Filter "DisplayName -like $DisplayName"
			}
			ELSEIF ($PSBoundParameters['ID'])
			{
				Get-Scsmobject @Splatting -Filter "Id -eq $ID"
			}
			ELSEIF ($PSBoundParameters['Filter'])
			{
				get-scsmobject @Splatting -Filter $Filter
			}
			ELSE
			{
				get-scsmobject @Splatting
			}
		}
		CATCH
		{
			Write-Error -Message "[PROCESS] An Error occured"
			$Error[0].Exception.Message
		}
	}
}

Function New-CAMVendor
{
	[CmdletBinding()]
	PARAM($Name)
	
	$properties = @{
		Name = $Name
	}
	New-SCSMObject -Class (get-scsmclass -name 'Cireson.AssetManagement.Vendor') -PropertyHashtable $properties
}


Export-ModuleMember -Function *