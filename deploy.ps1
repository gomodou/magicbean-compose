$hykpi_version = '2.6.5'
$current_dir = Get-Location
$new_foldername = 'hykpi-compose'
New-Item -Name $new_foldername -Path $current_dir -ItemType "directory"
cd $new_foldername

function Check-Command($cmdname) {
    return [bool](Get-Command -Name $cmdname -ErrorAction SilentlyContinue)
}

$processes = Get-Process "*docker desktop*"
if ($processes.Count -eq 0)
{
    Start-Service com.docker*
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
}

$cmdName="docker-compose.exe"
if (Check-Command -cmdname $cmdName) {
    if( (Get-WinUserLanguageList).LocalizedName.ToLower().SubString(0,2) -ceq "en" ) {
        curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.dockerhub.$hykpi_version.yaml"
    } else {
        curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.aliyun.$hykpi_version.yaml"
    }
    curl.exe -o prod.env "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/prod.$hykpi_version.env"

    Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d"
    docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d

    Write-Output "open http://localhost:9010"
    Write-Output "defaut username/password: admin / 123456"
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
