function Get-CAMClass
{
	<#
	.SYNOPSIS
		Function to retrieve Cireson Asset Management classes
	.DESCRIPTION
		Function to retrieve Cireson Asset Management classes
	.EXAMPLE
		Get-CAMClass
	.NOTES
		Francois-Xavier Cat
		@Lazywinadm
		www.lazywinadmin.com
		github.com/lazywinadmin
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

