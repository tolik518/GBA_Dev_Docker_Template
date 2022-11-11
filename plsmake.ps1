param(
    [switch] $BuildImage,
    [switch] $Run,
    [switch] $Compile,
    [switch] $GetIncludes,
    [switch] $Cleanup,
    [switch] $DeleteIncludes
)

[string]$VENDORNAME="returnnull"
[string]$PROJECTNAME="hellogba"
[string]$CONTAINERNAME="dkp_compiler"
[string]$USER=$env:USERNAME
[string]$COMPOSE=docker-compose -p ${PROJECTNAME} -f docker/compose/docker-compose.yml

[string]$GBA="C:\Program Files\mGBA\mGBA.exe"


if ($BuildImage) {
    Write-Host "BuildImage"
    docker build -f docker/${CONTAINERNAME}/Dockerfile . -t ${VENDORNAME}/${PROJECTNAME}/${CONTAINERNAME}:dev --build-arg uid=1000 --build-arg user=${USER}
}

if ($Run) {
    Write-Host "Run"
    Start-Process -FilePath ${GBA} "out/game.gba"
}

if ($Compile) {
    Write-Host "Compile"

    # backing up all the eviroment variables
    $orig_USER = $env:USER 
    $orig_CONTAINERNAME = $env:CONTAINERNAME
    $orig_PROJECTNAME = $env:PROJECTNAME
    $orig_VENDORNAME = $env:VENDORNAME
    $orig_PWD = $env:PWD

    # passing the variable to enviroment variables
    $env:USER = ${USER}
    $env:CONTAINERNAME = ${CONTAINERNAME}
    $env:PROJECTNAME = ${PROJECTNAME}
    $env:VENDORNAME = ${VENDORNAME}
    $env:PWD = Get-Location

    ${COMPOSE} up --exit-code-from ${CONTAINERNAME}

    # restoring old variables
    $env:USER = $orig_USER
    $env:CONTAINERNAME = $orig_CONTAINERNAME
    $env:PROJECTNAME = $orig_PROJECTNAME
    $env:VENDORNAME = $orig_VENDORNAME
    $env:PWD = $orig_PWD
}

if ($GetIncludes) {
    Write-Host "getincludes"
}

if ($Cleanup) {
    Write-Host  "cleanup"
}

if ($DeleteIncludes) {
    Write-Host "deleteincludes"
}

function Private:FunctionName {
       
}