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

# 1. Kiem tra trang thai Smart App Control (chi doc, khong sua registry)
$sacState = $null
try {
    $ciProp = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CI\Policy" -Name "VerifiedAndReputablePolicyState" -ErrorAction SilentlyContinue
    if ($null -ne $ciProp) {
        $sacState = [int]$ciProp.VerifiedAndReputablePolicyState
    }
} catch {
    $sacState = $null
}

if ($sacState -eq 1 -or $sacState -eq 2) {
    $sacLabel = if ($sacState -eq 1) { "On (Bat bat buoc)" } else { "Evaluation (Danh gia)" }
    Write-Host ""
    Write-Host "[CANH BAO] May tinh nay dang bat Windows Smart App Control ($sacLabel)." -ForegroundColor Yellow
    Write-Host "Do phan mem chua co chung chi Code Signing thuong mai (DigiCert / Sectigo / Azure Trusted Signing)," -ForegroundColor Yellow
    Write-Host "Windows Smart App Control se chan chay tep tai ve tu Internet." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Huong dan tiep tuc:" -ForegroundColor White
    Write-Host "  1. Trong cua so Windows Security -> Smart App Control (vua mo)," -ForegroundColor White
    Write-Host "     chuyen Smart App Control sang che do Off (Tat)." -ForegroundColor White
    Write-Host "  2. Quay lai cua so PowerShell nay va nhan Enter de tiep tuc." -ForegroundColor White
    try {
        Start-Process "windowsdefender://smartapp"
    } catch {
        Write-Host "  (Mo thu cong: Settings -> Privacy & security -> Windows Security -> App & browser control -> Smart App Control)" -ForegroundColor DarkGray
    }
    Write-Host ""
    Read-Host "Nhan Enter sau khi da tat Smart App Control (hoac nhan Ctrl+C de huy)" | Out-Null
}

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