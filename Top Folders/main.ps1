<#$folders = Get-ChildItem -Path c:\ -Directory -Force

$folderinfo = @()

foreach ($folder in $folders){
$foldersize = (Get-ChildItem -Path $folder.FullName -File -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
$size = $foldersize/0.1GB
Write-Host $size  $folder.FullName

$folderinfo +=[PSCustomObject]@{
    Path = $folder.FullName
    Size = [Math]::Round($size , 2)
    }

}

$topfolder = $folderinfo | Sort-Object -Property Size -Descending | Select-Object -First 10

$topfolder | Format-Table -AutoSize#>


$drive = "C:"

$subfolders = Get-ChildItem -Path $drive -Directory -Recurse -ErrorAction SilentlyContinue

foreach ($folder in $subfolders){
    $folderPath = $_.FullName
    $folderSize = Get-ChildItem -Path $folderPath -Recurse -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
    [PSCustomObject]@{
        folderpath = $folderPath
        sizeGB = $folderSize.sum/1GB

    }

    }

 $topfolder = $subfolder |Sort-Object -Property sizeGB -decending |Select-Object -First 10

 $topfolder
