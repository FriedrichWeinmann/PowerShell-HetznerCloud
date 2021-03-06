﻿function Get-HetznerCloudImage {
<#
	.SYNOPSIS
		A brief description of the Get-HetznerCloudImage function.
	
	.DESCRIPTION
		A detailed description of the Get-HetznerCloudImage function.
	
	.PARAMETER Name
		A description of the Name parameter.
	
	.PARAMETER Id
		A description of the Id parameter.
	
	.EXAMPLE
		PS C:\> Get-HetznerCloudImage
#>
    [CmdletBinding(DefaultParameterSetName='None')]
    param(
        [Parameter(ParameterSetName='ByName')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name
        ,
        [Parameter(ParameterSetName='ById')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Id
    )

    $Uri = "$($HetznerCloud.Server)/images"
    if ($PSCmdlet.ParameterSetName -eq 'ByName') {
        $Uri += "?name=$Name"

    } elseif ($PSCmdlet.ParameterSetName -eq 'ById') {
        $Uri += "/$Id"
    }

    $Result = Invoke-RestMethod -Method Get -Uri "$Uri" -Authentication Bearer -Token $HetznerCloud.Token
    
    if ($PSCmdlet.ParameterSetName -eq 'ById') {
        $Result.image

    } else {
        $Result.images
    }
}
