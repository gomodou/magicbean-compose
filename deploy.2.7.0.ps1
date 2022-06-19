$hykpi_version = '2.7.0'
$current_dir = Get-Location
$new_foldername = 'hykpi-compose'
New-Item -Name $new_foldername -Path $current_dir -ItemType "directory"
cd $new_foldername

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

$cmdName="docker-compose.exe"
if (Check-Command -cmdname $cmdName) {
    if( (Get-WinUserLanguageList).LocalizedName.ToLower().SubString(0,2) -ceq "en" ) {
        curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.dockerhub.$hykpi_version.yaml"
    } else {
        curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.aliyun.$hykpi_version.yaml"
    }
    curl.exe -o prod.env "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/prod.$hykpi_version.env"

    curl.exe -o start.ps1 https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/start.ps1
    curl.exe -o stop.ps1 https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/stop.ps1
    curl.exe -o uninstall.ps1 https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/uninstall.ps1

    Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d"
    docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d

    Write-Output "open http://localhost:9010"
    Write-Output ""
    Write-Output ""
    Write-Output "How to stop the service ?"
    Write-Output "cd $new_foldername"
    Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml stop"
    Write-Output ""
    Write-Output "How to delete the service ?"
    Write-Output "cd $new_foldername"
    Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml down"
    Write-Output ""
} else{
    Write-Output "Please open the docker and docker-compose first, and then execute install script again"
}
