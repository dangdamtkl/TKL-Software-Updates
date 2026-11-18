param(
    [ValidateSet("Prompt", "All", "Pen", "Pdf")]
    [string]$App = "Prompt"
)

$ErrorActionPreference = "Stop"
$Repo = "dangdamtkl/TKL-Software-Updates"
$RawBase = "https://raw.githubusercontent.com/$Repo/refs/heads/main"
$RelBase = "https://github.com/$Repo/releases/download/latest"
$WorkDir = Join-Path $env:TEMP "TKLInstaller"
New-Item -ItemType Directory -Path $WorkDir -Force | Out-Null

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "  TRINH CAI DAT CHINH THUC - TRUNG KIEN LANDSCAPE (TKL)" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

# 1. Tai va cai dat chung chi tin cay TKL
$cerPath = Join-Path $WorkDir "TKL-Root-CA.cer"
try {
    Invoke-WebRequest -Uri "$RawBase/TKL-Root-CA.cer?t=$([DateTimeOffset]::UtcNow.ToUnixTimeSeconds())" -OutFile $cerPath -UseBasicParsing
} catch {
    Invoke-WebRequest -Uri "$RelBase/TKL-Root-CA.cer" -OutFile $cerPath -UseBasicParsing
}
Unblock-File -Path $cerPath -ErrorAction SilentlyContinue

Import-Certificate -FilePath $cerPath -CertStoreLocation "Cert:\CurrentUser\TrustedPublisher" | Out-Null
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if ($isAdmin) {
    Import-Certificate -FilePath $cerPath -CertStoreLocation "Cert:\LocalMachine\Root" | Out-Null
    Import-Certificate -FilePath $cerPath -CertStoreLocation "Cert:\LocalMachine\TrustedPublisher" | Out-Null
}
Write-Host "[OK] Da nap chung chi chu ky so Trung Kien Landscape (TKL)." -ForegroundColor Green

# 2. Tai manifest moi nhat
$manifestJson = $null
try {
    $manifestJson = (Invoke-WebRequest -Uri "$RawBase/update-manifest.json?t=$([DateTimeOffset]::UtcNow.ToUnixTimeSeconds())" -UseBasicParsing).Content
} catch {
    $manifestJson = (Invoke-WebRequest -Uri "$RelBase/update-manifest.json" -UseBasicParsing).Content
}
$manifest = $manifestJson | ConvertFrom-Json

if ($App -eq "Prompt") {
    Write-Host ""
    Write-Host "Chon phan mem muon cai dat:" -ForegroundColor Yellow
    Write-Host "  [1] TKL Pen (v$($manifest.apps.TKLScreenPen.latestVersion))"
    Write-Host "  [2] TKL PDF (v$($manifest.apps.TKLPdfStudio.latestVersion))"
    Write-Host "  [3] Ca 2 phan mem (Mac dinh)"
    $choice = Read-Host "Nhap lua chon (1/2/3)"
    $App = switch ($choice.Trim()) {
        "1" { "Pen" }
        "2" { "Pdf" }
        default { "All" }
    }
}

$targets = @()
if ($App -eq "All" -or $App -eq "Pen") { $targets += "TKLScreenPen" }
if ($App -eq "All" -or $App -eq "Pdf") { $targets += "TKLPdfStudio" }

foreach ($key in $targets) {
    $entry = $manifest.apps.$key
    $url = $entry.installerUrl
    $fileName = [System.IO.Path]::GetFileName($url)
    $dstExe = Join-Path $WorkDir $fileName

    Write-Host ""
    Write-Host "Dang tai $($entry.appName) v$($entry.latestVersion)..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $dstExe -UseBasicParsing
    Unblock-File -Path $dstExe -ErrorAction SilentlyContinue

    if (-not [string]::IsNullOrWhiteSpace($entry.installerSha256)) {
        $actualSha = (Get-FileHash -Path $dstExe -Algorithm SHA256).Hash
        if (-not $actualSha.Equals($entry.installerSha256, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Loi kiem tra SHA-256 cho $fileName"
        }
    }

    Write-Host "Dang chay bo cai dat $fileName..." -ForegroundColor Green
    Start-Process -FilePath $dstExe -Wait
}

Write-Host ""
Write-Host "Hoan tat cai dat!" -ForegroundColor Green