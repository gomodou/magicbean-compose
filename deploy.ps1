$magicbean_version = '2.6.2'
$current_dir = Get-Location
$new_foldername = 'magicbean-compose'
New-Item -Name $new_foldername -Path $current_dir -ItemType "directory"
cd $new_foldername

if( (Get-WinUserLanguageList).LocalizedName.ToLower().SubString(0,2) -ceq "en" ) {
    curl.exe -o docker-compose.yaml "https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/docker-compose.dockerhub.$magicbean_version.yaml"
} else {
    curl.exe -o docker-compose.yaml "https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/docker-compose.aliyun.$magicbean_version.yaml"
}

curl.exe -o prod.env https://magicbean-release.oss-cn-hongkong.aliyuncs.com/magicbean-compose/prod.env

Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d"
docker-compose.exe --env-file prod.env -f docker-compose.yaml up -d

Write-Output "open http://localhost:9010"
Write-Output "defaut username/password: admin / 123456"
Write-Output ""
Write-Output ""
Write-Output "How to stop?"
Write-Output "cd $new_foldername"
Write-Output "docker-compose.exe --env-file prod.env -f docker-compose.yaml down"
Write-Output ""
Write-Output ""
