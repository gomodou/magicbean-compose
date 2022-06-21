$hykpi_version = $args[0]

docker-compose.exe --env-file prod.env stop
docker-compose.exe --env-file prod.env down

if( (Get-WinUserLanguageList).LocalizedName.ToLower().SubString(0,2) -ceq "en" ) {
    curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.dockerhub.$hykpi_version.yaml"
} else {
    curl.exe -o docker-compose.yaml "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/docker-compose.aliyun.$hykpi_version.yaml"
}
curl.exe -o prod.env "https://hykpi-release.oss-cn-hongkong.aliyuncs.com/hykpi-compose/prod.$hykpi_version.env"
